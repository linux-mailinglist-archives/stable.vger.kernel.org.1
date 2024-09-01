Return-Path: <stable+bounces-72279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7DE9679FC
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7982817DC
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A69717CA1F;
	Sun,  1 Sep 2024 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="awsD1+WF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F61C68C;
	Sun,  1 Sep 2024 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209411; cv=none; b=JhCHNOmhPqTywxI2V+1FutcftvNkW2pggqUp89x8VfC4jxPTEvpvKwH2kFbWlfWf8hA7WKCsnvz1/LGFhSW3M9RP3YZg6nYSPBjYAD+o+WnEbnuh/m7Jspgi4aA22r+jBimSkYN5NLAh+rbQoe7wnigN3e37TKAaJ2fjXVhdPUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209411; c=relaxed/simple;
	bh=LzqwIbGZvD1pPEwi6jRWu0xSuPnaSXr+9faBwOGgPbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjCydB8l2Tf+05v9XMtZwblxinuLasEAZaX7qz6Qb1E+kQuij4WDabdHKAP1tCchHLrh+b4QzkgMc6mRgbG/IVT4jfhPG0AeSOlXLct4Iqrp0o+Hv8F2I1SUePZiRAbbNsn+DcERoWp1jUMfch1PCt5W6AF848GqWQ4mIohYuxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=awsD1+WF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E521C4CEC3;
	Sun,  1 Sep 2024 16:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725209410;
	bh=LzqwIbGZvD1pPEwi6jRWu0xSuPnaSXr+9faBwOGgPbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=awsD1+WF6sAJm3mSfw6zn84v9fKf2ldqhpKfTUuavq8A8tDlSEQeQQ2R2piVXdHJf
	 N7Vhd/iQDwKakTSU2Ga4vYAISS+XeeS9TAOqM3EyCAoLmbVuuzV/qjZQD7la0IVEny
	 d75PN8JF4fvlSqJx2m+HgYykvQblrm5sNpxs+pqk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 5.10 004/151] thunderbolt: Mark XDomain as unplugged when router is removed
Date: Sun,  1 Sep 2024 18:16:04 +0200
Message-ID: <20240901160814.260256184@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160814.090297276@linuxfoundation.org>
References: <20240901160814.090297276@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit e2006140ad2e01a02ed0aff49cc2ae3ceeb11f8d upstream.

I noticed that when we do discrete host router NVM upgrade and it gets
hot-removed from the PCIe side as a result of NVM firmware authentication,
if there is another host connected with enabled paths we hang in tearing
them down. This is due to fact that the Thunderbolt networking driver
also tries to cleanup the paths and ends up blocking in
tb_disconnect_xdomain_paths() waiting for the domain lock.

However, at this point we already cleaned the paths in tb_stop() so
there is really no need for tb_disconnect_xdomain_paths() to do that
anymore. Furthermore it already checks if the XDomain is unplugged and
bails out early so take advantage of that and mark the XDomain as
unplugged when we remove the parent router.

Cc: stable@vger.kernel.org
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/switch.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2584,6 +2584,7 @@ void tb_switch_remove(struct tb_switch *
 			tb_switch_remove(port->remote->sw);
 			port->remote = NULL;
 		} else if (port->xdomain) {
+			port->xdomain->is_unplugged = true;
 			tb_xdomain_remove(port->xdomain);
 			port->xdomain = NULL;
 		}



