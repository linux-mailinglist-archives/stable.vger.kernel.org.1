Return-Path: <stable+bounces-36294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2298589B3FE
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 22:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CB5281A40
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 20:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFFC1E893;
	Sun,  7 Apr 2024 20:31:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F062582;
	Sun,  7 Apr 2024 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712521892; cv=none; b=ljtfZ786JgVy3FG/Eq112Eo0PhMTTri8FQWvEGi4FOL8dpi9DD78+LIAD7xnE5LTo+IabdJp8+hs2prrDJW+aP/9XSnikusCuVifZd97+gHc8iCVW8Ds0bGhoKMSxMBdsyE+9qYqeG230jVOxcULd1Z3dSThd+IV0/7Z73bZvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712521892; c=relaxed/simple;
	bh=icmfxrHIFihnVSMTiFYEzBjqDIJxGgEgxKi0q9Y/mm8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t4/a++bmBd9Q+UbKsEjNwo7BvnvhEAydeuxQa/QlGuDHeAZQsZbzipHpWfwxhPJCQMiUBPa+jjyHWmFAcfQT6mUze8bJ/ueJtfuR6oEdVX7OFpVAxHgCu0L3jmCGKLtWsfnDa9ojKNKu0mTSRPmJIJVn+xOKkrCI2Bv3Hkq9RT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b69f53.dsl.pool.telekom.hu [::ffff:81.182.159.83])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006FBD1.000000006613029A.00261F18; Sun, 07 Apr 2024 22:31:21 +0200
Message-ID: <890d28a0578a42333c2f63b5feb086bd8d1c98e9.camel@irl.hu>
Subject: Re: Patch "ASoC: tas2781: mark dvc_tlv with __maybe_unused" has
 been added to the 6.8-stable tree
From: Gergo Koteles <soyer@irl.hu>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Date: Sun, 07 Apr 2024 22:31:21 +0200
In-Reply-To: <20240407201311.1155107-1-sashal@kernel.org>
References: <20240407201311.1155107-1-sashal@kernel.org>
Autocrypt: addr=soyer@irl.hu; prefer-encrypt=mutual;
 keydata=mDMEZgeDQBYJKwYBBAHaRw8BAQdAD5oxV6MHkjzSfQL2O8VsPW3rSUeCHfbx/a6Yfj3NUnS0HEdlcmdvIEtvdGVsZXMgPHNveWVyQGlybC5odT6ImQQTFgoAQRYhBLSYvEYEgjzzEMQCqgtEJzXf/1IRBQJmB4NAAhsDBQkFo5qABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEAtEJzXf/1IRmdYA/0bE1BX7zOGKBgCa1DwzH2UHXawSKLpptADvI/ao6OOtAP4+wYgpR0kWR28lhmkRTpzG/+8GiMWsT60SV2bz9B7sCbg4BGYHg0ASCisGAQQBl1UBBQEBB0CPo8ow/E97WYtaek9EsLXvsvwpBsjWLq5mMOgJL/ukCwMBCAeIfgQYFgoAJhYhBLSYvEYEgjzzEMQCqgtEJzXf/1IRBQJmB4NAAhsMBQkFo5qAAAoJEAtEJzXf/1IRklEA/ipTfAI/onzNwZIp9sCdnt0bLhR5Oz8RD/FpbrJV1v7eAP0c/C6NQPDPWbQpobBR0pf1eTjWXjjr1fj2jxSvWbMRCw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Sun, 2024-04-07 at 16:13 -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
>     ASoC: tas2781: mark dvc_tlv with __maybe_unused
>=20
> to the 6.8-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>=20
> The filename of the patch is:
>      asoc-tas2781-mark-dvc_tlv-with-__maybe_unused.patch
> and it can be found in the queue-6.8 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>=20
>=20

Is this necessary for stable? It only fixes a W=3D1 build warning.

Regards,
Gergo


