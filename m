Return-Path: <stable+bounces-61333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8542293BA3A
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 03:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CCB1F225AA
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 01:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C40F63AE;
	Thu, 25 Jul 2024 01:39:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175BE5C89;
	Thu, 25 Jul 2024 01:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721871559; cv=none; b=Wsh9wgjtVhGwUTkwof0icsAzzxVqSZSfUM1KLKBqv87GIdt2KinRaXgUIDfYilS8Vlu9H+GrUmmtE1ggOndt43iGpv0TNCdqmGb06IP3MgYvFm7ueNdQIvqPx5sPoKXFuMJAipmk8QI0b8/6Vfaa168ybC7jy9V3DvPwZapv8DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721871559; c=relaxed/simple;
	bh=wM1qLzdgmg5DE5946Iqo4Egw8+dMNehGugv/fenT9S8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=igoHd1y6kvxQ7aMrOM+9RbllXZYg8VGx9uw+Pd+DIPCF1kadmLEdEr1eqtrQIrgiP7RC5SsHCoXWZHWu12BQSyUM87yuP+JDCEBZq20S8FbYWEoHeu7pxo0/y+BZ5hegGx/aGTTEsTMOOBp0EyNuUczPX8WB5xuO9702AbArGJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowAD3oECcrKFmBQ_bAA--.49981S2;
	Thu, 25 Jul 2024 09:38:50 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: jani.nikula@linux.intel.com
Cc: airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	make24@iscas.ac.cn,
	mripard@kernel.org,
	noralf@tronnes.org,
	sam@ravnborg.org,
	stable@vger.kernel.org,
	tzimmermann@suse.de
Subject: Re: [PATCH v3] drm/client: fix null pointer dereference in drm_client_modeset_probe
Date: Thu, 25 Jul 2024 09:38:36 +0800
Message-Id: <20240725013836.1708509-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87jzhakfn7.fsf@intel.com>
References: <87jzhakfn7.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:zQCowAD3oECcrKFmBQ_bAA--.49981S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFykWFykAr18ZFy8Gw43trb_yoW5Jr4kp3
	y5K3Z0yF4kXFnrCFZ2qw18Z3WS9wn5tr43Jas8Ja9rCas0grn3AryUKr4YgFWDCr12kw10
	qF4UKFWSgw1qvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOmhFUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

On Wed, 24 Jul 2024, Jani Nikula <jani.nikula@linux.intel.com> wrote:=0D
> On Wed, 24 Jul 2024, Ma Ke <make24@iscas.ac.cn> wrote:=0D
> > On Wed, 24 Jul 2024, Jani Nikula <jani.nikula@linux.intel.com> wrote:=0D
> >> On Wed, 24 Jul 2024, Ma Ke <make24@iscas.ac.cn> wrote:=0D
> >> > In drm_client_modeset_probe(), the return value of drm_mode_duplicat=
e() is=0D
> >> > assigned to modeset->mode, which will lead to a possible NULL pointe=
r=0D
> >> > dereference on failure of drm_mode_duplicate(). Add a check to avoid=
 npd.=0D
> >> >=0D
> >> > Cc: stable@vger.kernel.org=0D
> >> > Fixes: cf13909aee05 ("drm/fb-helper: Move out modeset config code")=
=0D
> >> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>=0D
> >> > ---=0D
> >> > Changes in v3:=0D
> >> > - modified patch as suggestions, returned error directly when failin=
g to =0D
> >> > get modeset->mode.=0D
> >> =0D
> >> This is not what I suggested, and you can't just return here either.=0D
> >> =0D
> >> BR,=0D
> >> Jani.=0D
> >> =0D
> >=0D
> > I have carefully read through your comments. Based on your comments on =
the =0D
> > patchs I submitted, I am uncertain about the appropriate course of acti=
on =0D
> > following the return value check(whether to continue or to return direc=
tly,=0D
> > as both are common approaches in dealing with function drm_mode_duplica=
te()=0D
> > in Linux kernel, and such handling has received 'acked-by' in similar =
=0D
> > vulnerabilities). Could you provide some advice on this matter? Certain=
ly, =0D
> > adding a return value check is essential, the reasons for which have be=
en =0D
> > detailed in the vulnerability description. I am looking forward to your=
 =0D
> > guidance and response. Thank you!=0D
> =0D
> Everything depends on the context. You can't just go ahead and do the=0D
> same thing everywhere. If you handle errors, even the highly unlikely=0D
> ones such as this one, you better do it properly.=0D
> =0D
> If you continue here, you'll still leave modeset->mode NULL. And you=0D
> don't propagate the error. Something else is going to hit the issue=0D
> soon.=0D
> =0D
> If you return directly, you'll leave holding a few locks, and leaking=0D
> memory.=0D
> =0D
> There's already some error handling in the function, in the same loop=0D
> even. Set ret =3D -ENOMEM and break.=0D
> =0D
> (However, you could still argue there's an existing problem in the error=
=0D
> handling in that all modeset->connectors aren't put and cleaned up.)=0D
> =0D
> =0D
> BR,=0D
> Jani.=0D
=0D
Indeed, it was my negligence. Thank you very much for your guidance. I will=
=0D
carefully analyze according to your instructions and resubmit a new patch.=
=0D
=0D
Best regards,=0D
=0D
Ma Ke=0D


