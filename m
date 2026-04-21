Return-Path: <stable+bounces-240219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKlpEIK652mu/wEAu9opvQ
	(envelope-from <stable+bounces-240219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 19:57:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8ED43E3E0
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 19:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE4863013C7F
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C752EA172;
	Tue, 21 Apr 2026 17:57:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F839B4A9;
	Tue, 21 Apr 2026 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794228; cv=none; b=BZeCYhuTR8k0+pmWqLjnw6ZyrPcMyZoP1CxVxo3hB8xQgPal6GZU4POzra2dMjHsRbIi4+GIg+vY238/m0+xJ5u4xd24NUnXJQV8dee4niE6TfTzr2KKKzjH/4KcaIZhxS3ZhW+WaPlDYFXh4JAel12tI/WDP/qD2r88PgLHi+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794228; c=relaxed/simple;
	bh=ZJ7H1auxxRbdYEZM+F6EJurqSnDoygvAYELKfyGrTVw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KNVptrNpsXWKIkv0y++AEehqexuo24/U4z/Tk1nuVwCe0c5IRsUkPDI9D1/7OATlbAtpnCEp3+botZ/tgM5+fujAlqZIQea4aHuKg8DGihtRNUdUwn0U3fSq4rzJVQC+z6OLfcPaRpUuOz6wp+vJXIbf0CAY3c2nVP7WnWOpf2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.10])
	by APP-03 (Coremail) with SMTP id rQCowABXPONnuudpPWnLDg--.22657S2;
	Wed, 22 Apr 2026 01:56:56 +0800 (CST)
Message-ID: <3318ac65b5d16875bdee6b79c808290b93a5d23a.camel@iscas.ac.cn>
Subject: Re: [PATCH] pvr: acquire vm_ctx->lock before mapping memory to GPU
 VM
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster
 <matt.coster@imgtec.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann	 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter	 <simona@ffwll.ch>
Cc: Brendan King <Brendan.King@imgtec.com>, Danilo Krummrich
 <dakr@kernel.org>,  Donald Robson <donald.robson@imgtec.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Wed, 22 Apr 2026 01:56:55 +0800
In-Reply-To: <20260421175228.1928742-1-zhengxingda@iscas.ac.cn>
References: <20260421175228.1928742-1-zhengxingda@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:rQCowABXPONnuudpPWnLDg--.22657S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr47GrW7XF1Uury5WF1fCrg_yoWfGrcE9r
	WUGw1kuFWxGan3tr40g34F9Fy3KrWjg3y8u3y5tr45J3y7tr1vqFs8W3sxZrnrXa18KFn0
	93Z0qrWFyrs7ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8YjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
	xwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07b0SoAUUUUU=
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240219-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[imgtec.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhengxingda@iscas.ac.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid,iscas.ac.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E8ED43E3E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Oops, wrong commit title prefix... Wrote too commits for Mesa recently.

Should be drm/imagination: instead.

Will send a replacement patch (and remove an unreachable Cc).

Quite sorry,
Icenowy

=E5=9C=A8 2026-04-22=E4=B8=89=E7=9A=84 01:52 +0800=EF=BC=8CIcenowy Zheng=E5=
=86=99=E9=81=93=EF=BC=9A
> The drm gpuvm code doesn't protect find operation against map
> operation,
> and the driver needs to ensure a map operation shouldn't happen when
> a
> find operation is in progress.
>=20
> As all occurences of drm_gpuva_find*() is already guarded by
> vm_ctx->lock, make pvr_vm_map() to acquire this lock to prevent
> disturbing any find operation.
>=20
> This fixes occasional NULL deference in drm_gpuva_find*().
>=20
> Cc: stable@vger.kernel.org
> Fixes: 4bc736f890ce ("drm/imagination: vm: make use of GPUVM's
> drm_exec helper")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>


