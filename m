Return-Path: <stable+bounces-89582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAB79BA4AB
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 09:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925871C20997
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 08:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0AC5588B;
	Sun,  3 Nov 2024 08:25:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2781E1F5E6
	for <stable@vger.kernel.org>; Sun,  3 Nov 2024 08:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730622306; cv=none; b=I06RlXLn8jOJN3hE7kWi/W3AX8/e+CIAQPHzVD1Th0Hu+FzRe+nso8XVDd68YPgW1Cr1R8F8E5a9Kg30D0ro8bRLL54GzDJI+1MzvR9g5b/n7H/dgRbc/J/iZbUDqND9MGxrNJlWgo4JVtXGjj8vatai31DHMlmbGo88YboZhaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730622306; c=relaxed/simple;
	bh=kBEdzyy6Q7aqllTjcx6qJiQ7xsMfUerf2KTOEieR02I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hnu4bdrk/Cf+1gDlyOyXtCK/ge35ifK4wVcXp32Jf7kH501djGktlvh/rU+BQUIL7mQr4YvyvYLVv8ev7kbx2rNheDzvb6Rw/fLwlyNcu+AHBOaBQCkKDOgfVHcttcF/RYkLT1uSjtTnHsW+15SVT9/TeIW70VFBfl93lvrcx5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: =?utf-8?Q?Ulrich_M=C3=BCller?= <ulm@gentoo.org>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev,
    He Lugang <helugang@uniontech.com>,
    Jiri Kosina <jkosina@suse.com>
Subject: [REGRESSION] ThinkPad L15 Gen 4 touchpad no longer works
Date: Sun, 03 Nov 2024 09:24:59 +0100
Message-ID: <uikt4wwpw@gentoo.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

After upgrading from 6.6.52 to 6.6.58, tapping on the touchpad stopped
working. The problem is still present in 6.6.59.

I see the following in dmesg output; the first line was not there
previously:

[    2.129282] hid-multitouch 0018:27C6:01E0.0001: The byte is not expected for fixing the report descriptor. It's possible that the touchpad firmware is not suitable for applying the fix. got: 9
[    2.137479] input: GXTP5140:00 27C6:01E0 as /devices/platform/AMDI0010:00/i2c-0/i2c-GXTP5140:00/0018:27C6:01E0.0001/input/input10
[    2.137680] input: GXTP5140:00 27C6:01E0 as /devices/platform/AMDI0010:00/i2c-0/i2c-GXTP5140:00/0018:27C6:01E0.0001/input/input11
[    2.137921] hid-multitouch 0018:27C6:01E0.0001: input,hidraw0: I2C HID v1.00 Mouse [GXTP5140:00 27C6:01E0] on i2c-GXTP5140:00

Hardware is a Lenovo ThinkPad L15 Gen 4.

The problem goes away when reverting this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/hid/hid-multitouch.c?id=251efae73bd46b097deec4f9986d926813aed744

See also Gentoo bug report: https://bugs.gentoo.org/942797

