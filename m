Return-Path: <stable+bounces-240060-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD3aMHUo52kf4wEAu9opvQ
	(envelope-from <stable+bounces-240060-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:34:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D313B437A5E
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E1673010226
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4C639A803;
	Tue, 21 Apr 2026 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH436sAU"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DC335C18C
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756163; cv=pass; b=SIToP4lgiKGxeaD1EqDgFO8GQUzKsx0PzxeqyOnJQa1vgvelPcXqk7T0FviOOFVEbFS/sa1I+9DS8kR3UvxueBNuHZM5/DNq+HM5FMkFz4sJo2kbkvY0R5lOLhEzLvjl43LdFIFcYv8Sxj88TP/fzG7JxKXVAchfU7ZDIVsGcSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756163; c=relaxed/simple;
	bh=EM5/wsiqPSxKiDjoKcMXJB6hI3dOOLlAitKrGI6fT1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BL+i8fGrjVuZM7RQq2/WTQz7krdyIyjmR+uNtirVr9VxrFZxArQ7VAlmjyhVOPUfbhy1EP01v5ZtsiLbWaEMlUhIN7vPGbY/7LzXDoAmVvyOmIOPDvnVc807H78BKny/EJaIP6DIlysksWEc7seMVA3CPWWCVRx2sKteU54xj5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MH436sAU; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-650789b22e3so4398038d50.1
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 00:22:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776756161; cv=none;
        d=google.com; s=arc-20240605;
        b=XdSukYs77SxyFZHihspWooXZzClnnvqxD2rmyQYk9/rI+nHWtneQEj7xe37iMDLs5f
         zn/h1prx+C6Egjy5U7/Qi4HNMwM9WKHDrLEzzMBrUK01m9Tyh62SnYV0SwSx/S791GF6
         2wLUVr1CiGSb4AwhGW/z41Gsn2OlQcWViJArIpEPeUnpsrLEh9lyXUiVe5vKFFWC0u67
         x+sLYWHI+c65Civ0Q4oQqKlLQkKy7lYxVnQd+Pht5HV4Nls1i34v3HGCw8axn6RYMlfW
         ncBrY6sRxVl0DVLhF9o0AbvJSQ3E/k/3DFCK88cUB2DnFoBJ29FDW7QmmT50ort+9hW3
         JWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/i73lLmWxPxd2Vk1aTjCtWFnsDkH2eHKVxdhJqebLk8=;
        fh=xCtN9jGI6q6vbmU8Ayd+esGE0nXC7oIbtvg8kXh3/2A=;
        b=gFNSgqNY9ozlqcLZj1OFjuDgqiUxS0lJI3KNqZeVloiSRVCO3+EWBt4xq71rEP9nX4
         e+Y83NlC9zJBLiRjCoftpTMnGiytKDkO14AXu+OYHFz5Afg0GpOrVNWp9sycI9doo/EN
         a921YGt8Ss5C0+Y8VQoJl3kzy4PbvBum753fW5ESn7T2gTxpxZ3dhubCPumI5EzRyyHO
         1sxIRaPE1yruJcxH4eqNcDO8YCD2vmr4cqISJg/rT3c8gKbpllLERZ7qb6HPmNxNbJdM
         /7NoCc8aXo8KDk2PcEmrM/TkL9pfvBuTaiPbU0MJdsB9LzJfkm7T9oosQxtvJ5+9EDTQ
         2YRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776756161; x=1777360961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/i73lLmWxPxd2Vk1aTjCtWFnsDkH2eHKVxdhJqebLk8=;
        b=MH436sAUNAALhyrSAZQUG2r5dqjOgM9KHmbQcv4vpVcZ2Wv0ya/dYKgY/f2qeWZXEo
         VapfskFn/MCZ5pRi9jVtpHxNK3IGQNdumJq69+Pe9GI7i+FQW00vDUIWT695a2wWl2iM
         hGazcqvJxgWPdWRT3aF6Lbhu+uSv0PAzEntV3rabt5pCTPEV/NBa+E50yZj+XNTZC1A/
         m0SNcDRGhzZwQLM5yv5n5tIcp2dCucZU4A0s9TszrJMdZGzqQjVGVneejpa1deog7e28
         DqqW8zUnO50gMcr7yNySecvVea1rKK4WXlokVvyQLcnEMcdQYEXhPpNHftLTQS3t3QOd
         FaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776756161; x=1777360961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/i73lLmWxPxd2Vk1aTjCtWFnsDkH2eHKVxdhJqebLk8=;
        b=oyw7EDAr6FbOVhZwqSEvDYkwN9V+nEsM1n6uCU8KBVbCSRhYezPpqD8Fs+ij28Ahcg
         EJpYU0Q7DIBeOpuGJMLCxYGuQbPDlQam9b36xLqbIXklyu46Jt+EMQweEyYK04nTBBPK
         lgd/sfgotfKNCIYVO602NxLQVMpPlfnQ0J6FhZ8Q96wiU/ygYLR/xsmPdXJR7Y+VrsjM
         FIZiqwXVPEZIL35T5bF94NVQ4YUIAHqMovAu568vKKkpJjlbfJTJn4KtoFg9a2JfAXyJ
         60c0s3sNVN3FG4VDHVm3ajpafLoK0mjYT0eFOdGRw0Ka3qtxMoH27qGDdx8LSBpBybAr
         /lvA==
X-Forwarded-Encrypted: i=1; AFNElJ9ca8pa8XVtPngiOEqWjLJxsfC/OyQvZx4uR9Mo4cfXinAEsZYCg1jQgwsNMH6wSuSQfIDUzZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO1Os/u3Ggpeq2GFWYNYHsuDOTPzaNlmufWWAAUv2wLM0oztFp
	0OAhAlKJAi4tZA5m/6bGCj6vSvMkkx5VXdyhRPKsSCxxZZQUAYMBRfh+cCEpQc+r/QiDvccSmL2
	FbswuUSJuRrfEdDXCtnsKs0O7J1vQTBcDALe1
X-Gm-Gg: AeBDietp67yNwbhotxJDDWz0mOXVWU08jbthBZth093IaMvGZPpg045Qk2i/gKhuMkz
	/ZpLgka6ySOp/xAENkgX4Gg4OVtkn3n0n+MPuSJp3noMm3QpyWkbf/s+ju95Tb4G0zA19o4XMZV
	N2psS7BtrVkZ7QF1SiQN8kPDhCILRuygcI+P3PX7p3t7wdh64XI+aSRME7/8BkLvJH8ar5pFgU8
	wRVVTgsRi7//iEQ1AbY8YtcqmIeNeqVzNMgwqdrm2kgK9Q9T2PQAMQlcdlMJPD/sbjUknBBXmeX
	+8jmzS5wick49VqeI94=
X-Received: by 2002:a53:c058:0:20b0:652:e4d7:2491 with SMTP id
 956f58d0204a3-65310b4055emr12666394d50.54.1776756161016; Tue, 21 Apr 2026
 00:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406014959.186669-1-james010kim@gmail.com>
In-Reply-To: <20260406014959.186669-1-james010kim@gmail.com>
From: James Kim <james010kim@gmail.com>
Date: Tue, 21 Apr 2026 16:22:30 +0900
X-Gm-Features: AQROBzDsinVxLjRY_nvwUegbCSinSPCsLBTwrHifo1aYbA02JsY0Z_K6TnV2xgg
Message-ID: <CAPdMtfc576fswdikBZnGg5m2R2Ch8r++zwX-a-7VrRANBiE3Cg@mail.gmail.com>
Subject: Re: [PATCH] rapidio: mport_cdev: fix sequential UAF in dma_req_free()
To: linux-kernel@vger.kernel.org
Cc: mporter@kernel.crashing.org, alex.bou9@gmail.com, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240060-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.crashing.org,gmail.com,vger.kernel.org,linuxfoundation.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[james010kim@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: D313B437A5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Just a gentle reminder about this patch.

It might have been missed during the previous merge window.

Thanks,
James

On Mon, Apr 6, 2026 at 10:50=E2=80=AFAM James Kim <james010kim@gmail.com> w=
rote:
>
> dma_req_free() drops the mapping reference under buf_mutex and then
> dereferences req->map again to unlock the mutex.
>
> If kref_put() drops the last reference, mport_release_mapping() frees
> the mapping, and the subsequent mutex_unlock() dereferences a freed
> object. This is a sequential (non-racy) use-after-free.
>
> Fix this by caching map and md before kref_put() and using the cached
> md for mutex unlocking.
>
> Fixes: 4b0986a36 ("rapidio: add mport character device support")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Kim <james010kim@gmail.com>
> ---
>  drivers/rapidio/devices/rio_mport_cdev.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> Resending this patch as it might have been missed due to the merge window=
.
>
> No changes since the previous submission.
>
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/d=
evices/rio_mport_cdev.c
> index 7df466e22282..5fb6ec439028 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -582,9 +582,14 @@ static void dma_req_free(struct kref *ref)
>         }
>
>         if (req->map) {
> -               mutex_lock(&req->map->md->buf_mutex);
> -               kref_put(&req->map->ref, mport_release_mapping);
> -               mutex_unlock(&req->map->md->buf_mutex);
> +               struct rio_mport_mapping *map =3D req->map;
> +               struct mport_dev *md =3D map->md;
> +
> +               mutex_lock(&md->buf_mutex);
> +               kref_put(&map->ref, mport_release_mapping);
> +               mutex_unlock(&md->buf_mutex);
> +
> +               req->map =3D NULL;
>         }
>
>         kref_put(&priv->dma_ref, mport_release_dma);
> --
> 2.25.1
>

