Return-Path: <stable+bounces-185983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D53FBE2618
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC903188DA63
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E0E3176E6;
	Thu, 16 Oct 2025 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HtMtyiQz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604A2D3A7B
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606887; cv=none; b=a+Ma0dQyZfJ+m4PmlYSQLlRnR9H2w/qEzy0Xb65RaRFPjU64wzOMog4xeTHo6yZh4O/Eai+Gzpg10XpMZmLEY1mvXQZTV04Rw4JoWmJLj9kOfbHYqa2NuqE9BDkQkV3GAoUgkBMSLNYbm5bBV5bI2F9G0eJz3IuKiz98wwtpD4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606887; c=relaxed/simple;
	bh=MoYv9NhuG2P+Qml/x/PKBBl4U1Tf28e8J52JpPZTD1Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FRIeFHXiLxAmOeM+vL5NpZfab+STUQNz3WWNDADeHnS15L4C6pbkG6v+uT7pXQQxMuBtuYh7U+Iw8Nf90O2wFKUy6elVSJYA8mAPdD7Cx2iRm+1O6Qpa+dXuTIlY3anwW/UqA0qYeY3YELcloNedNCaYSm2k2SUSyHeoyC0fgyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HtMtyiQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD39C116D0;
	Thu, 16 Oct 2025 09:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760606886;
	bh=MoYv9NhuG2P+Qml/x/PKBBl4U1Tf28e8J52JpPZTD1Y=;
	h=Subject:To:Cc:From:Date:From;
	b=HtMtyiQzYOj0fWlGGUuJ1dNaBuUBRrX7onvY7Ub2R0Lt7GaPp908B1vzpItLJLptu
	 JBa7/T64DOnpnEOowSaEDoGAnjajrD5n/Kcy8BSBuJWFp9dSxT5WIxCwS3uXEsb/B7
	 +hEUM/sdbhpVw9FcA2f+bOLtdE9qP9gZg1/lt1fo=
Subject: FAILED: patch "[PATCH] drm/xe: Extend Wa_13011645652 to PTL-H, WCL" failed to apply to 6.17-stable tree
To: julia.filipchuk@intel.com,daniele.ceraolospurio@intel.com,lucas.demarchi@intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org,stuart.summers@intel.com,thomas.hellstrom@linux.intel.com,vinay.belgaumkar@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 11:27:56 +0200
Message-ID: <2025101656-edgy-outbreak-15f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x 6fc957185e1691bb6dfa4193698a229db537c2a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101656-edgy-outbreak-15f9@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6fc957185e1691bb6dfa4193698a229db537c2a2 Mon Sep 17 00:00:00 2001
From: Julia Filipchuk <julia.filipchuk@intel.com>
Date: Wed, 3 Sep 2025 12:00:38 -0700
Subject: [PATCH] drm/xe: Extend Wa_13011645652 to PTL-H, WCL
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Expand workaround to additional graphics architectures.

Cc: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Cc: Stuart Summers <stuart.summers@intel.com>
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.17+
Signed-off-by: Julia Filipchuk <julia.filipchuk@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://lore.kernel.org/r/20250903190122.1028373-2-julia.filipchuk@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
index 0cf2b3c03532..338c344dcd7d 100644
--- a/drivers/gpu/drm/xe/xe_wa_oob.rules
+++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
@@ -32,7 +32,8 @@
 16022287689	GRAPHICS_VERSION(2001)
 		GRAPHICS_VERSION(2004)
 13011645652	GRAPHICS_VERSION(2004)
-		GRAPHICS_VERSION(3001)
+		GRAPHICS_VERSION_RANGE(3000, 3001)
+		GRAPHICS_VERSION(3003)
 14022293748	GRAPHICS_VERSION_RANGE(2001, 2002)
 		GRAPHICS_VERSION(2004)
 		GRAPHICS_VERSION_RANGE(3000, 3001)


