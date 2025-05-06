Return-Path: <stable+bounces-141817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12360AAC6CE
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 15:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698764A5F65
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 13:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC1E280A22;
	Tue,  6 May 2025 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byhdXSb3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C2A27FB0D;
	Tue,  6 May 2025 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539075; cv=none; b=Jq79SQvjahpIYTOelf1TgyHfGZnrVwe+pshhwmTmwtnUsl5gKDw37s+QVrTg/kWGl8K7HLLRvLGKJnkdbloxtijIao2+0SIvwiZ+3AeztNo/2HCs2V+FIb+K1BD3ST2TGAtILaLQikejpH2J7Hhc0ttc0Weig/P7uJANU+qYjsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539075; c=relaxed/simple;
	bh=5IGNnrCW9/fyS6L3OffLvdNxo2LX/iRpie5dVPbjSnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lApQrmyuSJs2C37M1FJLrW/kZ+Imrrd/hCgpN6q8tzA/Oj8WID81EN0QWg90+xO0BvyL2wseLsDTzb9B4qdAJAELyzVE5zHjsBptQUBmTLoTSFNwFIbN6dgRes1y7ndtdLbQ3r9uBZ+hQtP3Twxcq3h8e1EaPKz5705MqEz9u1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byhdXSb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17C76C4CEEF;
	Tue,  6 May 2025 13:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746539075;
	bh=5IGNnrCW9/fyS6L3OffLvdNxo2LX/iRpie5dVPbjSnk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=byhdXSb33LSjExtUoHQ7NvMH+2X5gdyZa0j8Ym3aR02xL8s22YtlA5xLF7hqGrwAW
	 v/ZzjXr9mIB6NWIp5wCrrxPWd7bzB0eZr8/db+EzhwQyYakQz4EYXu7Qry/kivzG6R
	 IfZn+iD9VRW+kLd22+4KPBkOB9YiQpnL7pL3SWg01bBJaOfSoHflM44qLljD7rjopr
	 SRYQJbvqsCqg1V0Lsvl+T/cecUg22n7vg73f5vj5UBGWLppbKOBBxQLeOEAny2Uc00
	 lE4mK7zeB2TTRjL0D43bLZ6c7k8QVAuCV0Iw2TLHU8B8P2lnLadY0Wruv7DelufkjL
	 uCDJv7dJI2H1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09845C3ABBF;
	Tue,  6 May 2025 13:44:35 +0000 (UTC)
From: Ignacio Moreno Gonzalez via B4 Relay <devnull+Ignacio.MorenoGonzalez.kuka.com@kernel.org>
Date: Tue, 06 May 2025 15:44:32 +0200
Subject: [PATCH v2 1/2] mm: mmap: map MAP_STACK to VM_NOHUGEPAGE only if
 THP is enabled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v2-1-f11f0c794872@kuka.com>
References: <20250506-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v2-0-f11f0c794872@kuka.com>
In-Reply-To: <20250506-map-map_stack-to-vm_nohugepage-only-if-thp-is-enabled-v2-0-f11f0c794872@kuka.com>
To: lorenzo.stoakes@oracle.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
 yang@os.amperecomputing.com, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, 
 Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746539072; l=1259;
 i=Ignacio.MorenoGonzalez@kuka.com; s=20220915; h=from:subject:message-id;
 bh=XYJ739wkAZuMZsfnywP2nc1z2w+5Ij9FOpsGEWHBfQc=;
 b=FjJF1IPEHxEAk9NENUASt8abzP6yyVRSTyhImKZhtYx9J7O9/mQG4RqOSowVDcWJpPNd22h+X
 p+VgdMW1gBIBP+ghs+nDXnM/fVrlbrUCu7QimDzvRUfSLt4hp1b/6oQ
X-Developer-Key: i=Ignacio.MorenoGonzalez@kuka.com; a=ed25519;
 pk=j7nClQnc5Q1IDuT4eS/rYkcLHXzxszu2jziMcJaFdBQ=
X-Endpoint-Received: by B4 Relay for
 Ignacio.MorenoGonzalez@kuka.com/20220915 with auth_id=391
X-Original-From: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
Reply-To: Ignacio.MorenoGonzalez@kuka.com

From: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>

commit c4608d1bf7c6 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE") maps
the mmap option MAP_STACK to VM_NOHUGEPAGE. This is also done if
CONFIG_TRANSPARENT_HUGETABLES is not defined. But in that case, the
VM_NOHUGEPAGE does not make sense.

Fixes: c4608d1bf7c6 ("mm: mmap: map MAP_STACK to VM_NOHUGEPAGE")
Cc: stable@vger.kernel.org
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Yang Shi <yang@os.amperecomputing.com>
Signed-off-by: Ignacio Moreno Gonzalez <Ignacio.MorenoGonzalez@kuka.com>
---
 include/linux/mman.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index bce214fece16b9af3791a2baaecd6063d0481938..f4c6346a8fcd29b08d43f7cd9158c3eddc3383e1 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -155,7 +155,9 @@ calc_vm_flag_bits(struct file *file, unsigned long flags)
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
 	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	       _calc_vm_trans(flags, MAP_STACK,	     VM_NOHUGEPAGE) |
+#endif
 	       arch_calc_vm_flag_bits(file, flags);
 }
 

-- 
2.39.5



