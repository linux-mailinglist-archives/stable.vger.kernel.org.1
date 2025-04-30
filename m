Return-Path: <stable+bounces-139121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4321AA45CC
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 10:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B731C1BA6BDB
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 08:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977F621ABC5;
	Wed, 30 Apr 2025 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="g6I84YrY"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955D821ABC6
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746002604; cv=none; b=PDtdwgsOds+NhkbS5a60TsyaZ9q5DPnO3D4FnTTdL4/+dqDThVo0y+fFvkWa3YEOYnlrucyL9ty1AVygvkmFiyJmVQxI/n+J1Cr8KULXAyqsAWekB2C+Pt1h4O2IMMwKpsZ9BzcydZBOGwAwas64/sox3m4chsjbD9UQVkPhuY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746002604; c=relaxed/simple;
	bh=KNpuHzwTaaTYpf7LfrnyBa2FI4gDtfLAyiquhlf2Pro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fa9HD9j3ujEcfGROmraKFqKYugWsOv7N0NLjUV+E+/D3PSml23od/WII/9On0HZhgOn2pTaTTDqZzA7RXnxfLdWz7qf534BqR/Bnjlhul82yDOi0BS4ShJq8+7hJAq0nrYLudAAGZikplnEBsTBcPFtUh2YeU372lsQlNJ5n1xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=g6I84YrY; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso7465211fa.1
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 01:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1746002600; x=1746607400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1qs81RVT7WGaI5EEDOkNWrLzSI42G5tmDul/p84+M0=;
        b=g6I84YrYc7F+yVADnY0iWBBQVEW70YSfRMYfb7DWa6B2Jg7pk5VzMDXMkxIJ7GYu+e
         mIOklJtUn1KhrqAp/2YrCVH1PKjNUH1vP2ZdKyb5SA+jfUYjFcbgJ6bj5D/zs1fiKu0w
         FQs1GLDeF+2zmBSDcAFi/knWqj5Wey4HB3iiSXY/agVgUezvklwnMjy6qbJt/lOO+Mz+
         QiA1kPP1Rf4hrUBxsV2Qr0yUi+BNNWlFZAg+yjMhlSxzk1d5OvyIg2P0WH6kCBfNMfmI
         DAqftad8D7xv3Lb+cCKSa+m1MCjltlzRkVzieJYBkbymu3XsgE4Z79vlDSB0y3Ers0jU
         EgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746002600; x=1746607400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1qs81RVT7WGaI5EEDOkNWrLzSI42G5tmDul/p84+M0=;
        b=q85A7alzMPlRb/NAuwZ+2BhMXQGmpxlF79LGol/jDRpw85CfRGPFy7qC8qGQCWj4Wm
         sGQwbG4sse2FfEMVO23N1KYLVFUaB6PNt1UmXVi50vwqSxqGM81SsiTLTIa8xqqK9vh/
         SP+sFDrCbqnxi86JeE+Shghg1q+W+IYtHKwJo0mLa1DX82JhG9wMTtCdWrhAWtN3vZFo
         rvIB0a08Rlc+cjMeeEdSnAPFLgkTp1Hn0yj9+Uqf1CoxIeI65shwYNwH3ZuB4yN6PywM
         /NNXHLs6lJApUGZWxSQJgShTiH7l737DgwKEFKB47+XCaZtxyD4yW1bWGC9jITI7iCIW
         5J4Q==
X-Gm-Message-State: AOJu0Ywx6xm3to9wGI2MvNlAnBKLz5gf7ySfcEChqvg7MryYgbSW+H37
	zfajRSPW3mBpQw/V/7g+BDBAZya6benqBYjzhqGy3cSGPdJVZoEYH7Sa9qqDnXClPakPK04CXsw
	y3hdLCXKCU/MFR051mx7uDuaXzRVovnsv9cBLzQ==
X-Gm-Gg: ASbGnctms4zwE5JlRFh7PeKgDs8DORD37L9u5r9frZ126mvIKh/bMlukcUvsvlaEU6i
	4HqZlR4Sb3FJIRZSFnmYZg3lxXrIbNU0QXNV6XqMda6dRRfhY7XLxU8t62S5ROsednzCcnJGErN
	eZQzS8wgJbzY5Gm9IaxZdSsmlpWtoeh0OBYOZ2WJMA1/Lzrmo=
X-Google-Smtp-Source: AGHT+IEj2xNmii2aVrB0HPnZcj1cS2DilF+s1D1CmUyT4TXXlXak86RbcnaZ+lF+p2b/bE6q5sm0vkwf9XHDx/ezzxg=
X-Received: by 2002:a2e:a808:0:b0:30b:a100:7fec with SMTP id
 38308e7fff4ca-31e7d4d6977mr5091471fa.12.1746002599538; Wed, 30 Apr 2025
 01:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPXr0uxh0c_2b2-zJF=N8T6DfccfyvOQRX0X0VO24dS7YsxzzQ@mail.gmail.com>
 <aBHgOsqA4qfe7LbN@c757f733ca9e>
In-Reply-To: <aBHgOsqA4qfe7LbN@c757f733ca9e>
From: Ezra Khuzadi <ekhuzadi@uci.edu>
Date: Wed, 30 Apr 2025 01:43:08 -0700
X-Gm-Features: ATxdqUFr52ls8iRfGl3SJa_g3FJ8AF-6Py3XE-3yWU18Haruwxmc1FYYj3yD3U4
Message-ID: <CAPXr0uxJg0kMu_N7Gxb14kVdhkFGXO_KbK5RxfAcY9dEA8vrEA@mail.gmail.com>
Subject: Re: sound/pci/hda: add quirk for HP Spectre x360 15-eb0xxx
To: kernel test robot <lkp@intel.com>, sound-dev@vger.kernel.org
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev, 
	alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

sound/pci/hda/patch_realtek.c: add quirk for HP Spectre x360 15-eb0xxx

Add subsystem ID 0x86e5 for HP Spectre x360 15-eb0xxx so that
ALC285_FIXUP_HP_SPECTRE_X360_EB1 (GPIO amp-enable, mic-mute LED and
pinconfigs) is applied.

Tested on HP Spectre x360 15-eb0043dx (Vendor 0x10ec0285, Subsys 0x103c86e5=
)
with legacy HDA driver and hda-verb toggles:

  $ cat /proc/asound/card0/codec#0 \
      | sed -n -e '1,5p;/Vendor Id:/p;/Subsystem Id:/p'
  Codec: Realtek ALC285
  Vendor Id: 0x10ec0285
  Subsystem Id: 0x103c86e5

  $ dmesg | grep -i realtek
  [    5.828728] snd_hda_codec_realtek ehdaudio0D0: ALC285: picked fixup
        for PCI SSID 103c:86e5

Signed-off-by: Ezra Khuzadi <ekhuzadi@uci.edu>
Cc: stable@vger.kernel.org

---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 877137cb09ac..82ad105e7fa9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10563,6 +10563,7 @@ static const struct hda_quirk alc269_fixup_tbl[] =
=3D {
   SND_PCI_QUIRK(0x103c, 0x86c7, "HP Envy AiO 32", ALC274_FIXUP_HP_ENVY_GPI=
O),
+  SND_PCI_QUIRK(0x103c, 0x86e5, "HP Spectre x360 15-eb0xxx",
ALC285_FIXUP_HP_SPECTRE_X360_EB1),
   SND_PCI_QUIRK(0x103c, 0x86e7, "HP Spectre x360 15-eb0xxx",
ALC285_FIXUP_HP_SPECTRE_X360_EB1),
   SND_PCI_QUIRK(0x103c, 0x86e8, "HP Spectre x360 15-eb0xxx",
ALC285_FIXUP_HP_SPECTRE_X360_EB1),
   SND_PCI_QUIRK(0x103c, 0x86f9, "HP Spectre x360 13-aw0xxx",
ALC285_FIXUP_HP_SPECTRE_X360_MUTE_LED),

On Wed, Apr 30, 2025 at 1:33=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi,
>
> Thanks for your patch.
>
> FYI: kernel test robot notices the stable kernel rule is not satisfied.
>
> The check is based on https://urldefense.com/v3/__https://www.kernel.org/=
doc/html/latest/process/stable-kernel-rules.html*option-1__;Iw!!CzAuKJ42Guq=
uVTTmVmPViYEvSg!PiCmDJsbkP48HY6ady0rbC21rGusuY-IjJ61JqQnp99GdHsbc5uEQDwV-Q9=
TeKK7R4THFV7fXQ$
>
> Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to ha=
ve the patch automatically included in the stable tree.
> Subject: sound/pci/hda: add quirk for HP Spectre x360 15-eb0xxx
> Link: https://urldefense.com/v3/__https://lore.kernel.org/stable/CAPXr0ux=
h0c_2b2-zJF*3DN8T6DfccfyvOQRX0X0VO24dS7YsxzzQ*40mail.gmail.com__;JSU!!CzAuK=
J42GuquVTTmVmPViYEvSg!PiCmDJsbkP48HY6ady0rbC21rGusuY-IjJ61JqQnp99GdHsbc5uEQ=
DwV-Q9TeKK7R4SyRLIbeQ$
>
> --
> 0-DAY CI Kernel Test Service
> https://urldefense.com/v3/__https://github.com/intel/lkp-tests/wiki__;!!C=
zAuKJ42GuquVTTmVmPViYEvSg!PiCmDJsbkP48HY6ady0rbC21rGusuY-IjJ61JqQnp99GdHsbc=
5uEQDwV-Q9TeKK7R4QdTQyPmg$
>
>
>

