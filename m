Return-Path: <stable+bounces-239998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mgbIG6+O5mkwyQEAu9opvQ
	(envelope-from <stable+bounces-239998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:38:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D95433C3B
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94170300B443
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E59386C10;
	Mon, 20 Apr 2026 20:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCkQy4xR"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AEC3859EC
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 20:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776717482; cv=pass; b=EAe5VgrUSB9pTpmSzWfFgdLVUUFE4M04DNiC3cMG+YNQChAI02a0qn0FgX+U/osM4Nkpu5kspC75yjERXxIFRh4fNc9ST4zEuqAJ91jfOFLMGEEfSZvVJngm8sxpkV4dPVY4gw06Y3wUIh3oQlMMR2CPghcFSRg2at80uVJNHm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776717482; c=relaxed/simple;
	bh=ADQUzdT1kaUTCl9XZzAUwQqYr9cALPSJzCeEmR/kFGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTC15br3rpphBQAXq74G1yioLNxU83byEhm/8LG8jqcMWhKehDPdlVpsk/81ZzuNuAuCs+KM0s3C6HnvuE7XRspGG+eMnqCMHW9MXy9oTSqnunOMnlrTk2a3v2gZohcSFqPlRtKMJrK+c0lpUFQxI/zG+khVKHZXDHpUIN8bwV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCkQy4xR; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6501d242e3fso3436396d50.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:38:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776717479; cv=none;
        d=google.com; s=arc-20240605;
        b=g7sufQZAg90vvztZWpkJfSN9AGUgSu3PNymzCbgABMbPB7SdyZ8HiSblQIgjooT0X6
         u/j0mEMcXr26x8tyuXgj+ZSpsOhSR1T+yNCfg04iIwZB9WypUfHznCnohNUx2WUbKDRe
         h5/42aOgeJm7+4N4OHJYOrQ1qyR1zTgTl2AdzIGggrtwnqjngvltGP1QJLefqNTy8EMK
         FTss4Ae3cqr1Xnu946Nt4Fm40pAs+jrEiLHNFWR4p1ZfQWLMn9tsPkCXvb8+j9ufrA5E
         xkLsLVNUxjXLlSe9Bc8MzqHHAlNgSv6y9odzIi4zaSVOtOo17n3Irso/CH3b4RPJ2nWS
         yTVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xljAePTDiU88jhAg2MqebjJvsqcljT34hn/5T4lFweU=;
        fh=p4PL4VRxMkiIoHzw9pUqadmy4ozjt2/ZjYp9Lc9lr0Y=;
        b=dtatYktCGmXtZyXfzRLbpky7shr6s8BXcCPp/I79iq0ZgVkw23u/+tspjmrUJidIsH
         u+8LaTnXVn2LLVPr6FV2QAWDQ8ZlUzOWx09uWYNwpJ4LExI2ISDihtaVSCSSyFHiY2Ax
         HU0e1dcscUr3vtJiFLIKZL5aYl9dfruJvY7RKWB/wUGtwjeHVag5ZRM4UVyOxDKHR/Vw
         l2GoRabQBhOmzk2PpCw50TDW8pTscA9mkXbrFbK3oAbap+AUwqp2dv61sHJ4kBXGRoVg
         u9zWsvz9KikIIStf0BIokrRdmAfIcgg/4uMuXgnpesMZjNg3pPKFzIEgYjtyZobajipU
         Md5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776717479; x=1777322279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xljAePTDiU88jhAg2MqebjJvsqcljT34hn/5T4lFweU=;
        b=DCkQy4xR/8IyajeA7H4Q9UtNGrDz2azOo0vpd7awTeLWqj2Ll9Mpzr4FL4qASqw8U+
         l1mWdY4QcwA5v7ImPPKTSDTcl5YOvumrKaWmJGGEygTGntS3tXaXH5aOqslsKX7DrJDG
         RhCMjvIMOCWAk6UP11Qf1yGE8ab/FVCTPPwiJZg/9iAWCQHf0vUN6sBXI5f5fH/QGL9R
         J0y43z+y0iPOuIElX+TagONHGnWgB3xC0G351RIQq/5k+2FnmnOvvW5+SG+9OynhrrrN
         nOB9KhqI9VZ4+yDPmEiAMiCRR3Z2bi8aPKWwfUHMoyPGqATp7dAJhS3TnJKfj9lBDBSe
         AKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776717479; x=1777322279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xljAePTDiU88jhAg2MqebjJvsqcljT34hn/5T4lFweU=;
        b=Cb64rKLSfy/c/loO8xLFJQMZfdtIKuFVlCn8dmGSapEQEwp/bAa6mUSUTbGBo4hRfc
         XSd0DKKcxfMmt5Jx+GlLvFrPNSF8DDmfFJNPJxOJnniZp4rmpPFpbm+xFLiQ4BodBJjJ
         ruZ0KxYloUsTaF+L61PtdJ9a2FsbNwTJ1PywOG+aYgnHp6v8kro8XKPGQ1pfPvPTFfEG
         XgG569ujMcVZLw550cPtyQ+I4GABXiDkxgOpnijxa1bkH5I9kD+eDGtSgIgvSlWjOUwH
         1xMjyUMbQEFQbCyVfGkT3238eJrixTA679ZXdAocjQevtSHkIm43phaSNeM7FGZ3a8bz
         9EYA==
X-Forwarded-Encrypted: i=1; AFNElJ//l95JuOn+mtXh78lSs7BitwBJIk4MRg1/Kxeo+yMx5/nj8ppV07yg+/XQ1UzqFyXL1/1SBpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfsPELuaaFjK9fQqKuDQqhgxQCsljDJdCsVzTYZhOk67tUZQwf
	pSxiXYy9zp0ZXPMvREJPwzXOeFGkCuf5y4AXa5++cRw2+2Eu3m+k14mx16t7z8dS5O5rhYngiJ+
	sD+Hjvn9mHh7cFdVNfETklHQhfRrqjJU=
X-Gm-Gg: AeBDieuIWock2KIftEc5Ga35PBvVGpDmv6sWFJG/Rp8E8ZkMZbgnq40Ms1dQ5V3rRz5
	Kp3YMYkls8XVxZeiJ0WvBgueacsWDmSH+CuLHhs9LDar2C/mOArc9JojillJ78mn3rlE3TXSFW/
	Mr2NqVH5rJR6+Wp+pI4jt5yCF/4vZ6sKFWNuHz64csrOh19Dz18GtQJk97mZNrVdYDTC6+0CGjv
	tkn9kyzT8hT79he/7CUG3E+qYKRlh/+f+AI3sPHb+shOFKc820Zc28ctDbw/zt9PyrQ35mcT2Lx
	UGa+38ujOItVQQfsb7jCpmCNJnx81SqqRTJQX1jRu4k57JpzyLeyPkx/09RHvD04bVKPfKb+GWN
	KmWCI
X-Received: by 2002:a05:690e:418f:b0:651:c468:99a2 with SMTP id
 956f58d0204a3-65310a2bbafmr11722686d50.45.1776717479496; Mon, 20 Apr 2026
 13:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417104639.2608008-1-tristmd@gmail.com>
In-Reply-To: <20260417104639.2608008-1-tristmd@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Apr 2026 16:37:48 -0400
X-Gm-Features: AQROBzDy-6p2J796JPwwp_frm0FIgY1zcTHIOwEvqSjHrTNCfyTRMYOUjgz5Euo
Message-ID: <CABBYNZL-TZ_8XPpsH488Q8WtisfbX4jiBb_G0B3U-quiaYOAQw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: hci_bcm4377: validate firmware event length
 in completion ring
To: Tristan Madani <tristmd@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, sven@svenpeter.dev, 
	marcan@marcan.st, asahi@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239998-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: B6D95433C3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Tristan,

On Fri, Apr 17, 2026 at 6:46=E2=80=AFAM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> The firmware-controlled entry->len is used as the memcpy size for inline
> payload data without bounds checking when the PAYLOAD_MAPPED flag is not
> set. This causes out-of-bounds reads from the completion ring DMA memory
> for the HCI_D2H and SCO_D2H transfer rings.
>
> Add a length validation against the completion ring payload_size.
>
> Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 =
PCIe boards")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/bluetooth/hci_bcm4377.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4=
377.c
> index 925d0a635..5d2f594c2 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -755,6 +755,13 @@ static void bcm4377_handle_completion(struct bcm4377=
_data *bcm4377,
>         msg_id =3D le16_to_cpu(entry->msg_id);
>         transfer_ring =3D le16_to_cpu(entry->ring_id);
>
> +       if (data_len > ring->payload_size) {
> +               dev_warn(&bcm4377->pdev->dev,
> +                        "event data len %zu exceeds payload size %zu for=
 ring %d\n",
> +                        data_len, ring->payload_size, ring->ring_id);
> +               return;
> +       }
> +
>         if ((ring->transfer_rings & BIT(transfer_ring)) =3D=3D 0) {
>                 dev_warn(
>                         &bcm4377->pdev->dev,
> --
> 2.47.3

https://sashiko.dev/#/patchset/20260417104639.2608008-1-tristmd%40gmail.com

Comments seem valid.

--=20
Luiz Augusto von Dentz

