Return-Path: <stable+bounces-38401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968E28A0E68
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A95286BC9
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25861146A89;
	Thu, 11 Apr 2024 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XR2/gSwV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B05146A77;
	Thu, 11 Apr 2024 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830457; cv=none; b=fssoJiNwuAwzn4i8qox+t23jbzpXguiAU3bFq3c2hkADxldj24bY8jWVPKiTRuKMfRCCg0k7+o1fWyUdfbUXO5n5BairWplefKrGvtNqE2WgMfpVJbp0A8Cwiw3gN31lQjgZGR0fM84pe+Vc0Yi0Yu1pwt05nwxe0M7VQhKqD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830457; c=relaxed/simple;
	bh=zFnK7xyz+bYJ7yCO4KVW2N007oBgtR3nhb1vWYX11xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+BMEXTSs+Bjp4d2UgX9ZaEsCfxepWybDlqlrMEpbpiia5yN1DA1/bLOrDleiHw+qryFKhc6rVAKW0m9dvCOqK8vCyEjbFb1SrsiWsT0HqUFPbPdJ7scz7Y0AoMsGO9yS8GMqQC/h4k3JEwkhkOYykcvj8nPEAlVZDrmTlTmhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XR2/gSwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFC2C43390;
	Thu, 11 Apr 2024 10:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830457;
	bh=zFnK7xyz+bYJ7yCO4KVW2N007oBgtR3nhb1vWYX11xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XR2/gSwVcWFX7kgJQnDIw/FH+CuEWXdzeEraU3vMKv1+SQH0YCIa/0vsbmTImxbI8
	 EI+oOK6tQlA8Ta1rNJtwq1JS6QpXUqIR3izIn1RvMVGCALJPD0gHdN0nsOaxClhik+
	 h3OBwKsXUdEUmkDONGiB5DubFC2F4gmSTufy7CQQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lin Yujun <linyujun809@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 5.4 001/215] Documentation/hw-vuln: Update spectre doc
Date: Thu, 11 Apr 2024 11:53:30 +0200
Message-ID: <20240411095424.922424954@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
References: <20240411095424.875421572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Yujun <linyujun809@huawei.com>

commit 06cb31cc761823ef444ba4e1df11347342a6e745 upstream.

commit 7c693f54c873691 ("x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS")

adds the "ibrs " option  in
Documentation/admin-guide/kernel-parameters.txt but omits it to
Documentation/admin-guide/hw-vuln/spectre.rst, add it.

Signed-off-by: Lin Yujun <linyujun809@huawei.com>
Link: https://lore.kernel.org/r/20220830123614.23007-1-linyujun809@huawei.com
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/hw-vuln/spectre.rst |    1 +
 1 file changed, 1 insertion(+)

--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -625,6 +625,7 @@ kernel command line.
                 eibrs                   enhanced IBRS
                 eibrs,retpoline         enhanced IBRS + Retpolines
                 eibrs,lfence            enhanced IBRS + LFENCE
+                ibrs                    use IBRS to protect kernel
 
 		Not specifying this option is equivalent to
 		spectre_v2=auto.



