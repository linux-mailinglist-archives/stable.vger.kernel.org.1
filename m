Return-Path: <stable+bounces-254388-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKXGAtLFFWo5bAcAu9opvQ
	(envelope-from <stable+bounces-254388-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:09:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B6B5D95ED
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F09F5300183F
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE3A379ED8;
	Tue, 26 May 2026 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="AkDia0fu"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB3F3AC0CD
	for <stable@vger.kernel.org>; Tue, 26 May 2026 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811289; cv=pass; b=cBdGxZBhy/6NVwdpdo6U3RWNPEe6McnVnJ27L2FGIqWF/Jqg1U0w+/Q49XHt2SzdSZMn3loHABpSjWABcJH4DGy/nYh9qVwM8rKvW/buR8YKGIVjRWzv95Ls+Si8ItU1kXABZboRtgO9eLIQnt+XW/f9vVchp+YrMFoB/jiuG+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811289; c=relaxed/simple;
	bh=pVzqx11hjh7N1pH2gCRYfQFcHOCbS36d82t/QEbOWBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FulsR/SP11O97DJsTmSGYlNhZFsatqIyriQ9y9wvLH/DqXgzZWCqVA2TlIEIrxu/gYokZLuKFywYY8EVqNQ96sk0nuvnNrHdhlUXh2fDxv+UJEHxyE4ZhDo3G2aIO0RInj8PXSL2ggdFG2JPU2qPFyfyHaMqKkkOmXap38CacHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=AkDia0fu; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1329fc4bf77so9961081c88.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 09:01:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779811287; cv=none;
        d=google.com; s=arc-20240605;
        b=ht3wkCy1e9QlwfblAzMG/WDtS+ph4SU+Br2SsJZ5o710F1A2Wl+ihkibNM+tUJbQbN
         9JBHum5CA9XYA/a3N5iDrm3l6TV8bUc+kmwVfIBROw9d7ae4qH63rXWiA9VAriy/vRZh
         JsbS+Os8ODCb5ThYsqw8230JEqRuusoeq+EPMx+FhBoK1oKBO5XyomvdAuCj6Kmm/iO1
         7K+Lw2LtftGhliCwPcRxXjsjAStYIIF1QRj9un2ISlY2CfWjPVj+CwpDNWK1Cbojj70/
         Idb/XvttTBerXOKuC4776nOL/rTusze2WEwOPgJ0kr4jXIOJDAy4EA1dAVRWihYQCsUm
         ii7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JuWcfKbEhiOQ+qzwtoWjTZXdsQUx+LDCmslbk+9iAr4=;
        fh=+3y4sm1UQHapCnyucvfhvBWeLFKZrJWZiHlkvpnMSJA=;
        b=kS4wROTrHyqcAAMFcbGP+YG3u59qH46O35y69WDx6uFWBdSHuAhjiCuYu2lYUkSyEa
         IvLmC8Oqc2Hr1ojnnRR6OJEZmTotbv5Om2zdGrm0T2EqJJqA7KqarNl3Ic/NSEd3J/As
         CVWy2rPBLBntjSZnuPp0ayTLjV76ZvW2Amfv4S1uMWsiE7sfWggg9mrnblkkNhw+CpwE
         kpODUb6GXz7NV3tKSRKGdB3cheF5X+heXE6jTJ/gnj6uiEyTE3OmByLzxiN4/CYQPJzn
         q9DKmm5pxxgY3todvGD5/4mjK1MoVvIyp7qMiaJtDbjgHatcBuZw4RU3HH4cvpCd7XXw
         uVfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1779811287; x=1780416087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JuWcfKbEhiOQ+qzwtoWjTZXdsQUx+LDCmslbk+9iAr4=;
        b=AkDia0fuaRrNk+sjjE3h6BQVQcXhXFAy15t3bzec8494Otf75FZMwy1l4Fk46tWDH9
         pCiSy9rCQKurWuzZoFwOge0VTfUu0tc2gh2DMrpl6CyHviocZ5l+6Kj0YOBDrdNS7cXx
         8esdrOG4RG6tl3JIdxXr1PdamvZ9nCM2I6BaqhizCnr50O5JFMAuzEiMOHLPaQT1/gV6
         oRY7EURd+4qFPv7FxAg3s+pbfUoDqSFM5NaPHCCokcgoU0r1KSLy4s6s/zCzdqrVvEWe
         0Zc8OcYkx0+N+s+Jv8LMt8k93JWIdQRHCjJnTCQpuIqn8oZ7g0pGOG+35XX0TAzoBgvW
         J+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779811287; x=1780416087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuWcfKbEhiOQ+qzwtoWjTZXdsQUx+LDCmslbk+9iAr4=;
        b=I/bPZrNDrWychhOHOoihHpdnlrcT9g3zn4XCy1LABDrd5/GWFT1XNMgHmtIgbzm8CH
         Xn//ZdNq4tlcArDabix0jSH6dtwrRoL2RmGP+fvbOlFHXc3O1N0GO9njAOZKDScmjoSx
         9BoyCtGnGT55w0kVVCg8sVosD3pjcCgJgCgZBzSHzeALwATKtRP8CuKFjXVPRBzP1uma
         ukBICqm1Z9gWUQe5VRLDKZGzdsfhEYajGop0klkS87Ej3zxsuPbSNxs/fzZcj0V/rLT1
         TCB78dhVtKttj36ExeBNyVolQSO7yBTuUscHaz6RogD7kSPCt/HEg6iW3z1UY96v/rTa
         enyw==
X-Gm-Message-State: AOJu0Yw/IVFPe9jDk/L20l6+L4TlBXvrjombiteZOBhT4v3vR4uuoVkr
	TXz6B71+EBcnUZYqyAYNRFZMLSb57vbTLBCk+ANsx5CjdoLjcTfBbxhkwrnGub+e+CdRMwOKG7U
	ISwGSFbc2qTBMrDwVYsya7AefsSrcr89n2Iasz+4Afg==
X-Gm-Gg: Acq92OFRL85QoMTAOvenLkV50C5JbQVGt8tqaMtY6iT7VU+isQOJOQ6orq5m64FHF1X
	PSiEcrR/cn3ibfatxhwUF6gjJDbHpxx6Vr7yw1mXX1Sr9vY4oeMijg2D4VDnCe3/3LbC53m4KKY
	2jxzqJYlUJlzapIbCmZLOdu0UWhJNX/4J06ZOclGVE6CO4EhnA+9w8unVBPVOnRpkWQ6RrD+vnK
	j1Fkxn3yDNx/m6fBLkn9AQCEN4xGCV9kU0iUpZHL9mwcIVsmeUUpsMwTDf6q4fGP26Uj2PTUlk8
	1l5gGbiZCZ8s+NhdueM6/syb8DZ/bSfOnN+3p9+lRRkpI5CmW+z+KZXeUJEqwbGbsFawz34TYLM
	sbw==
X-Received: by 2002:a05:701b:240f:b0:134:fc38:4e5f with SMTP id
 a92af1059eb24-1365fb534b4mr4742656c88.22.1779811285149; Tue, 26 May 2026
 09:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520162134.554764788@linuxfoundation.org> <20260520162148.582539866@linuxfoundation.org>
In-Reply-To: <20260520162148.582539866@linuxfoundation.org>
From: Alice Mikityanska <alice@isovalent.com>
Date: Tue, 26 May 2026 18:01:06 +0200
X-Gm-Features: AVHnY4IJl_dvx3UZ0ZSVEcvY4jymeZHCGABK9TTIX9K4r8NdaAFfM045Bta1oQg
Message-ID: <CAD0BsJXt3QurRvFmOGNzh1juYYcQEst=3aYJmHiCCf-4DCZCVw@mail.gmail.com>
Subject: Re: [PATCH 6.18 648/957] ice: Remove jumbo_remove step from TX path
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[isovalent.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[isovalent.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254388-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[isovalent.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice@isovalent.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,isovalent.com:email,isovalent.com:dkim,msgid.link:url,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 80B6B5D95ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 at 19:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.18-stable review patch.  If anyone has any objections, please let me know.

Sorry for the late reply, I see it's already applied. This commit
depends on "net/ipv6: Drop HBH for BIG TCP on TX side" (part of the
same series [1]). As far as I see, this dependency was not applied to
stable trees, so removing this step from the drivers is not correct.
Either this commit should not be backported (reverted), or the entire
series can be backported, if eligible. This consideration applies to
all stable trees.

Thanks!

[1]: https://lore.kernel.org/netdev/20260205133925.526371-3-alice.kernel@fastmail.im/

> ------------------
>
> From: Alice Mikityanska <alice@isovalent.com>
>
> [ Upstream commit 8b76102c5e00d1f090e0c31d17b060c76d8fa859 ]
>
> Now that the kernel doesn't insert HBH for BIG TCP IPv6 packets, remove
> unnecessary steps from the ice TX path, that used to check and remove
> HBH.
>
> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Link: https://patch.msgid.link/20260205133925.526371-8-alice.kernel@fastmail.im
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Stable-dep-of: 1a303baa715e ("ice: fix double-free of tx_buf skb")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index 73f08d02f9c76..90dbe5266ce78 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -2594,9 +2594,6 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
>
>         ice_trace(xmit_frame_ring, tx_ring, skb);
>
> -       if (unlikely(ipv6_hopopt_jumbo_remove(skb)))
> -               goto out_drop;
> -
>         count = ice_xmit_desc_count(skb);
>         if (ice_chk_linearize(skb, count)) {
>                 if (__skb_linearize(skb))
> --
> 2.53.0
>
>
>

