Return-Path: <stable+bounces-2748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9D27F9F94
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 13:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DD7EB20D35
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 12:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90025179AA;
	Mon, 27 Nov 2023 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
X-Greylist: delayed 426 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 04:32:09 PST
Received: from deferred-out-02.cmp.livemail.co.uk (deferred-out-02.cmp.livemail.co.uk [213.171.216.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BC6187;
	Mon, 27 Nov 2023 04:32:09 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
	by deferred-out-02.cmp.livemail.co.uk (Postfix) with ESMTP id A23FDD0C5B;
	Mon, 27 Nov 2023 12:25:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at deferred-out-02.cmp.livemail.co.uk
Received: from deferred-out-02.cmp.livemail.co.uk ([127.0.0.1])
	by localhost (deferred-out-02.cmp.livemail.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eP-kny6QKGuP; Mon, 27 Nov 2023 12:25:04 +0000 (GMT)
Received: from smtp.livemail.co.uk (smtp-auth-out-04.cmp.livemail.co.uk [10.44.166.53])
	by deferred-out-02.cmp.livemail.co.uk (Postfix) with ESMTP id 46FEFD0C59;
	Mon, 27 Nov 2023 12:25:04 +0000 (GMT)
Received: from laptop.lan (host-78-146-56-151.as13285.net [78.146.56.151])
	(Authenticated sender: malcolm@5harts.com)
	by smtp.livemail.co.uk (Postfix) with ESMTPSA id EE7DBC5A53;
	Mon, 27 Nov 2023 12:24:59 +0000 (GMT)
Message-ID: <b9dd23931ee8709a63d884e4bd012723c9563f39.camel@5harts.com>
Subject: ASoC: amd: yc: Fix non-functional mic on ASUS E1504FA
From: Malcolm Hart <malcolm@5harts.com>
To: broonie@kernel.org
Cc: Sven Frotscher <sven.frotscher@gmail.com>, git@augustwikerfors.se, 
 alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org,  mario.limonciello@amd.com,
 regressions@lists.linux.dev, Sven Frotscher <sven.frotscher@gmail.com>,
 stable@vger.kernel.org
Date: Mon, 27 Nov 2023 12:24:59 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Like other ASUS models the Asus Vivobook E1504FA requires an entry in
the quirk list to enable the internal microphone.

Showing
with 7 additions and 0 deletions.
7 changes: 7 additions & 0 deletions 7
sound/soc/amd/yc/acp6x-mach.c
@@ -283,6 +283,13 @@ static const struct dmi_system_id
yc_acp_quirk_table[] =3D {
			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
		}
	},
	{
		.driver_data =3D &acp6x_card,
		.matches =3D {
			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER
INC."),
			DMI_MATCH(DMI_PRODUCT_NAME, "E1504FA"),
		}
	},
	{



I have this laptop and I have tested this patch successfully.

Malcolm

