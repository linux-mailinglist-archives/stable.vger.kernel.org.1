Return-Path: <stable+bounces-109491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C70FDA16276
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 16:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0281D3A2DB5
	for <lists+stable@lfdr.de>; Sun, 19 Jan 2025 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86281DF251;
	Sun, 19 Jan 2025 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="f59fuqJO";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="UrtWtyC7"
X-Original-To: stable@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EB6BE40;
	Sun, 19 Jan 2025 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737299142; cv=pass; b=TxGWRFhd76GG9B+CiQpX87gUpeCTndfxNC0xm8TyxJ4wOimH0ZmvIWN7p9QiA0N1yldZefJrisB9p2NKfPYR+ZIRP++mRACHZUEk9TnzE3kulP48fq0YotUc1upq24vC+WHSLAjIDlKOVPQj7EPntaEbuhUvxbIqVQJF6BsqsLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737299142; c=relaxed/simple;
	bh=js7MiuK4yn6yvesb1udJDB3nTTEempwvNv9RBIWTwdA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=IdLCBkTCIyR1HGfVr2GglScaEjZQlOWIfbFsDCZGyepUVwnPxAw64Zggi3O2LUyvK85c87d6HN0DWfhtrAH26MguyY5GIVq8m9+MCqYwTr8Gb6TVb17eE8OOGb7ABOHzT7aEjbD5IfDF+D2TEfD6+Nr4Mh7FvT6nOZLZLPuN04M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=f59fuqJO; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=UrtWtyC7; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
ARC-Seal: i=1; a=rsa-sha256; t=1737299110; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bSXmu4WOTHRfKsrej9J3zsXOR6/Kbt1eyMB2N/o6py7VqQhue1UztLJrR8CvLzaqmf
    NANZ/G5dJhsFf+GKkwEo01Lv7oNbs0oNe+vpX+T29B7V3DSoKi9ox47NN8BNq8yhsfQo
    0p1StBHr7sBWW501cAokO0+CzQEYk7PZ4FZrAv6Mn3gdjHUUcSFmGJi+IW24qUDws09f
    3jRiSvtOzQOE4nMq0vqNYAwH5/AkLPeUzxv28zUIaVFao/SQI9nfk6h8PXgPoLRWkpMl
    OlneP9C53OCfUyGuJqcPFdf75j0Aos6Ob7ZehlN7alEjck3DtUqW5eJuKt69NCIM24DF
    n+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1737299110;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ki3UxbLnk4PHDC41vZYF1ruM9tY2wjl13iVYeUH1NHY=;
    b=i5rjdMAv3GZ8RydOUedYM+BfjUisUNGEcVZHwCxbmnhUpqPdRYF4xrzcvJfS1n3elS
    D2sfwUsyifAmG31mefUGycQCYFdXqu/sqAaiX64JyJ5NxCbCjaH/4ZM5p1fJiM5RHHRg
    qf/P9LcyOuYm6c4s1ZPeznc2qcDWPIJ+UhbFQTNjLB14IQKJHPazzKGx16z7++hBZGVM
    iVGK6lrYE9AsZcba2lPhSrIshtTtephmiRFcUlr0X+7AvAYboSFaOF+V//n/smm/ia9f
    zSMJMc5g04SPJ/Vz37xvtIICh2jj42+lI2moNPeMVEXedRb9ILqMF0zD2H/+mFaSrpBm
    cXVA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1737299110;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ki3UxbLnk4PHDC41vZYF1ruM9tY2wjl13iVYeUH1NHY=;
    b=f59fuqJOhq80fXEmX0sFflckjIM1m5tZKvKPmzZsUKqGWdRUqjLInek8CHFmXzBHvu
    xWcwfYh8TsY4NnYg5LWpENoDgXQIpbKN0CRMFCTW8yJD6vadgGT9Vw9dM3EtSucdnCQR
    tK/kM8t832OFa6g8ELbq5EHQeuGD9kYdgzizCNFqKYxVXvoQ5hcv1ysLo9VsBAZO/36b
    Rh/SUwvMG/1/YcynQnX5T/JwxOqNas9P3wp2qMXSZ3SvEXDrOCoKgmqn+5TguuuVqsRm
    EKAhbPl51yeTs9OmPEBdgl6x9NhGHDJFen9Le18p4WUeR/MoV2z5LuoZGNBj7PuziPeX
    78ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1737299110;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=ki3UxbLnk4PHDC41vZYF1ruM9tY2wjl13iVYeUH1NHY=;
    b=UrtWtyC7bYw4S06ht8+lbB7RjWsxMQF7HjdSiZiJUXAqfQKlVduNARsBtBqR+G+xOl
    kn5ODwTgxbva8sKAMxAg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lFzL1yeD4Z"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 51.2.21 DYNA|AUTH)
    with ESMTPSA id Qeb5b110JF5AjqT
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Sun, 19 Jan 2025 16:05:10 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH v2] Revert v6.2-rc1 and later "ARM: dts: bcm2835-rpi: Use
 firmware clocks for display"
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <808a325f-81bc-4f5d-8c07-fa255ef2d25a@gmx.net>
Date: Sun, 19 Jan 2025 16:04:59 +0100
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 devicetree <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 linux-rpi-kernel@lists.infradead.org,
 arm-soc <linux-arm-kernel@lists.infradead.org>,
 Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F33BB1D-2210-421B-A788-8484C23DF4C6@goldelico.com>
References: <cb9e10dfb4f50207e33ddac16794ee6b806744da.1737217627.git.hns@goldelico.com>
 <808a325f-81bc-4f5d-8c07-fa255ef2d25a@gmx.net>
To: wahrenst@gmx.net
X-Mailer: Apple Mail (2.3776.700.51.11.1)

Hi Stefan,

> Am 19.01.2025 um 01:36 schrieb Stefan Wahren <wahrenst@gmx.net>:
>=20
> Hi,
>=20
> Am 18.01.25 um 17:27 schrieb H. Nikolaus Schaller:
>> This reverts commit 27ab05e1b7e5c5ec9b4f658e1b2464c0908298a6.
>>=20
>> I tried to upgrade a RasPi 3B+ with Waveshare 7inch HDMI LCD
>> from 6.1.y to 6.6.y but found that the display is broken with
>> this log message:
>>=20
>> [   17.776315] vc4-drm soc:gpu: bound 3f400000.hvs (ops =
vc4_drm_unregister [vc4])
>> [   17.784034] platform 3f806000.vec: deferred probe pending
>>=20
>> Some tests revealed that while 6.1.y works, 6.2-rc1 is already broken =
but all
>> newer kernels as well. And a bisect did lead me to this patch.
> I successfully tested every Kernel release until Linux 6.13-rc with =
the
> Raspberry Pi 3B+, so i prefer to step back and analyze this issue =
further.

Yes, I would be happy with any solution.

> What kernel config do you use ?

a private one which enables application specific drivers.

> What is the value of CONFIG_CLK_RASPBERRYPI ?

CONFIG_CLK_RASPBERRYPI is not set

I checked where this is defined and it is in bcm2835_defconfig and
multi_v7_defconfig by

4c6f5d4038af2c ("ARM: defconfig: enable cpufreq driver for RPi")

which hides this requirement quite well and got therefore unnoticed...

Setting CONFIG_CLK_RASPBERRYPI=3Dy makes HDMI work without my proposed =
revert.
Tested with v6.2.16, v6.6.72, v6.12.10 and v6.13-rc7.

BR and thanks,
Nikolaus=

