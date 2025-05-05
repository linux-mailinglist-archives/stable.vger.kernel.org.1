Return-Path: <stable+bounces-140482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F283FAAA969
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC565A29DC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BD429B790;
	Mon,  5 May 2025 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEW8USIO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F82359620;
	Mon,  5 May 2025 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484948; cv=none; b=grN4YsZUbC1okOoXf+rI+uza2v02oWp7WcPDHcFw9eaPDBpzdeGOZHuhScFbw1nqxUw4y7ZTOsFJpROPzrd9WZA7RG6beFSr8O39FkaaJ6IFLkK7ITOwxRw0SsHS946vivDloIlsb69g0eLeOyEkk0cujBIOSwKAlO6BKuXD/8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484948; c=relaxed/simple;
	bh=kB3Of2TAfMWjq4ISnDkHwtPTUxxjDoqlJgVbF9jFa5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jt+NZz0Ah3pAbsLcoO2JCtKmfMuLx/LrBZkcgz1KCxqP/AOQuGtMBZFZL6md1Y1UW92HY8KYJJ1Xnu2zzlVDrq4NGotNRg1RZu0Di9enPQjB5fwrZvJmwo4bXNJsplEZHbFK3oj6T8HQtOr7EqDWPeaeWwPD9XKDF30EGZWvPds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEW8USIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CA8C4CEED;
	Mon,  5 May 2025 22:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484947;
	bh=kB3Of2TAfMWjq4ISnDkHwtPTUxxjDoqlJgVbF9jFa5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tEW8USIOHYaxsOxllC0RCLxuGJfEibAjzNccldMpjj/NmOw73MX78T3IQom6QS8hh
	 B3FFcKY6NThbXniWQt1p3pxTMqd4bgOs4gnjDYWbSlhFVtOqM1x5fAZLyIwzJGFKqZ
	 d/wXcMCHvq2XnOo6pxpdT/a1+R6sx+/mb5/UjBDume4afUY14mmJpHfXgQmDNXvgU1
	 yLyJ170yA93RwBGmjsCM6nGrXWgX9gosloq2FtQGiVM5aXu0CATjovcpHARgDo7T/f
	 9+icDeIqu9EaX7sFXS/4XPd9w6ojbEYD8aFswcup6Bfmh1cGhS30AsMpkMTuYLEGm0
	 ktUs+LRSHEzJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	dave.hansen@linux.intel.com,
	richard.weiyang@gmail.com,
	benjamin.berg@intel.com,
	kevin.brodsky@arm.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 090/486] um: Update min_low_pfn to match changes in uml_reserved
Date: Mon,  5 May 2025 18:32:46 -0400
Message-Id: <20250505223922.2682012-90-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Tiwei Bie <tiwei.btw@antgroup.com>

[ Upstream commit e82cf3051e6193f61e03898f8dba035199064d36 ]

When uml_reserved is updated, min_low_pfn must also be updated
accordingly. Otherwise, min_low_pfn will not accurately reflect
the lowest available PFN.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20250221041855.1156109-1-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/kernel/mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index a5b4fe2ad9315..6ca9ea4a230bc 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -70,6 +70,7 @@ void __init mem_init(void)
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
+	min_low_pfn = PFN_UP(__pa(uml_reserved));
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
-- 
2.39.5


