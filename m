Return-Path: <stable+bounces-77946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E9398845B
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3ABC2815A5
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECAC18C014;
	Fri, 27 Sep 2024 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HEfGpk1M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01CC18C011;
	Fri, 27 Sep 2024 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439995; cv=none; b=TY8bhxzyQMmQlXO8wQr3mO/8ZevUyRRrad3KKvYGbFy9MaC7h1Dj8UZ/ne8NFqN3ScyZX1X0oXptR07kOEHAGjDjtMBftZWfbo2WdgomGIg/BkkCjXxfEZJ1O0ovmlN8AM3EtqacfitqDs2jlLvbqH577sHajdzAdetpXUocsqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439995; c=relaxed/simple;
	bh=ZdbI8R2DH4H4W/PTTWNf0GkH3SfnqbhmIpnYQNQk0yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ym0+7JM0FUDegJAYzZpxfr0UlA8fMhaTwQ11Z7ZptYGfzs1keZrYQpvPQr69+Q9dqjO4xDBdwvlvKG5fTbqah8ACD+edXuV0RmE2KqF2gxr4JAep2Q5K9ViQqPaicXaa5n7HfwQmdeEJGY0UtXEEc4Ma8GtYO86GYALEtVlS2B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HEfGpk1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF84C4CEC4;
	Fri, 27 Sep 2024 12:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727439994;
	bh=ZdbI8R2DH4H4W/PTTWNf0GkH3SfnqbhmIpnYQNQk0yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HEfGpk1MdiuU47YFy2cNaWQLTCo2prQeD3oDT3+vZp3jGCi/nsn1CYkB04oZqONsj
	 +2pC5VV0EaH4r58456Cha/EfcYiWYrl0QPM75Bs3tWNpunW17JXZT3TFGVHswnxvOV
	 6ijtIlN1yktO5WxsQtviMYhZLtMMevEcCT6hbQ7E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 6.6 50/54] x86/mm: Switch to new Intel CPU model defines
Date: Fri, 27 Sep 2024 14:23:42 +0200
Message-ID: <20240927121721.823822179@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121719.714627278@linuxfoundation.org>
References: <20240927121719.714627278@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Luck <tony.luck@intel.com>

commit 2eda374e883ad297bd9fe575a16c1dc850346075 upstream.

New CPU #defines encode vendor and family as well as model.

[ dhansen: vertically align 0's in invlpg_miss_ids[] ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20240424181518.41946-1-tony.luck%40intel.com
[ Ricardo: I used the old match macro X86_MATCH_INTEL_FAM6_MODEL()
  instead of X86_MATCH_VFM() as in the upstream commit. ]
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/init.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -261,21 +261,17 @@ static void __init probe_page_size_mask(
 	}
 }
 
-#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
-			      .family  = 6,			\
-			      .model = _model,			\
-			    }
 /*
  * INVLPG may not properly flush Global entries
  * on these CPUs when PCIDs are enabled.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
-	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,      0),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,    0),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, 0),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0),
 	{}
 };
 



