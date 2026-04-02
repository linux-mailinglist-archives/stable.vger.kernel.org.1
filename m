Return-Path: <stable+bounces-233089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDmQDrmuzml+pQYAu9opvQ
	(envelope-from <stable+bounces-233089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 20:00:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB1A38CD0B
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 20:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 513ED30151FA
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 17:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D63E3E3C53;
	Thu,  2 Apr 2026 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRDRVYNO"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22933E345
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152786; cv=pass; b=ApzoTT7YDPXojDA8MEfyxXT1MwULDZDgFXSJpP7+zJbJVXG3abCzxfBgD+Yk7cqz9Yo13WIV0Lo+7fXU8p/1YFZVxtSFfL412X6hmEMXDRaoXlQfbxvJz29tB0m/VNEK9GehS/2Kuy1rZHgNY+5Iu2nZamrlfVHfSl7e570FXn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152786; c=relaxed/simple;
	bh=h8gHEy/QL3Y3VZcM7IRovIie1NiKMInttxTfM5XohLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=To3LTBCtef80dtfeRg8wsGGntq7UwjV9ciK35A6ZhWmsIqeL8N3Zi1DAHZwKo6jXJFg7JrYbzIowtycn8pG3j0I0exCmJYQLwMrymAEmlCr9A0lQmzg1/SUsSZfMDAG/rXZe1h7eiDlL6SbyiOMRApDHoPIhonVjZ4irZ4Ed5hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oRDRVYNO; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-467e044082dso380752b6e.1
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 10:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775152784; cv=none;
        d=google.com; s=arc-20240605;
        b=bH3QHVQ0gwmonV73oqozHe6M5m6ROKUgRyclSpry6XeG4cgZ7b+yqOXNXLS8KXXJgq
         vYceEn98a2rpW9972uh2lCPrNijvpngwkvx2kNX4zpBwIIzO9m4ynA8HtQejYGc9a5vO
         fTktrjzGbfAiTCssFnSmX4mEv/6FNGZ1UTfdtR7BywSBCKiLzF2q8/Nuwgv9n4pEAdYV
         ZBLWMgZVRc1aU1yio6F8pKX6zAWpoHZwaSz45BGVTIV3UkOY+H9qK3nO8Q+i0fWL5De2
         d4MuVfYN2GRsy5XZWObU9dfiaYKIv4dJt9PradGBuf+RW9z4wZZaI4BQCfOpdg862T6F
         attQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6oBfne9CbSq7TsD62MWlNbHi0ATWBOcJIGvZTuwhO+c=;
        fh=NdE7swk3N+ooXCViKR3mHHBp/V+Z7YMBFUxR+C8RbEI=;
        b=Uj87X1tkOBhaeamkqzHyiFnI1wrl9KmIDYolOCIiEwOHgkpeQ+DCqlIbIKRtqWrNKG
         VcJwsqqDRrKfeTrGnfsfu4wLmfdcrX8XmrmYvDuAJJCahXWNvfq8uVI6TmY193PJNJKf
         WeNwznvgV65sfUtyqKYOGd0Nsuys3mOvTgzdk+6rSq/0LYpzY0iQEgI3IjhEOjd37iTm
         kpdrNhiF8M9NYvXC2Z9+Qd32uxgnpodi+CvYsbZHl+7RLR2w0RiD97pHOBQyz+k0GKRg
         IAvQNtNrlYCQ5MBisztx7ZiiGwqSY9NVLnnW6FKwRoCeR5R/pnIbwEbiqmxHjXpJQ3Ei
         eyiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775152784; x=1775757584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oBfne9CbSq7TsD62MWlNbHi0ATWBOcJIGvZTuwhO+c=;
        b=oRDRVYNOSBnKTAVxkKyJokHK2Vhg+kFwt7+Xj9sByK9O45EV2zmpAj26sVwijltkRb
         TmZ3LRBGwWKalGdDgffYzclhmxhQXGr8Td2zvBNZDER+HUhkgnMHlk27gQc84p6xnTb+
         6HU1buSBR9filMZRXdm6P2u2bMbrgskRFadqHQYMDcJjw0nvl5z1K6pPCOfAtcIXCjTH
         pTx8UMrgZ0oXMU06DIRwEYcwhRuxPicjnbEya2AvMmUnuIjdaIjcXryjzv9+NwKaoM7T
         CFSd9G3v3QG6sBX8V7fEGz5hg9oVHDobnUFr+EkNAKFvxBCuhTpXwD9UEpEoGl/6QGeI
         Bdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775152784; x=1775757584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6oBfne9CbSq7TsD62MWlNbHi0ATWBOcJIGvZTuwhO+c=;
        b=KWjhOw/32EuA8EVI6QqI0Xw4De4Hw9APV9/iz0JSm6QCIyyWJDuNFDaRObrZYESd2g
         nL9S9xHr2AsQIOf0KatJqT2VCEiCaXsuJMy9+2qmSb9khOmjtjnriI9IGNOxt3fTXLsw
         mKm2q0+p7kxt0pegAChrZ/4Y3loRdNgpEeGRZ51gk21Bv+f5DnCxXXlzMst4SgOXQYXK
         1p3rntU0co+x/iJ1VyYE26ANbox+u+hw1CBKr1j0XdEP8rjQ/7i/EOnNVamOztxlsjc8
         OuR9BRAVLUVmrR3WOMHfprdC0ETbjycHt5Pzj0+4izaJt7gy9NS0b+7mSj3vCCpbEN+h
         WjQg==
X-Forwarded-Encrypted: i=1; AJvYcCXkp0EG+dIDVcOF76RQ7gVsBUZVhioM8OC2P9gdQH/tllKJQgOL5aiLaZsil55IAa9+qd/qQK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Keog3J9X3P+zGd0Bkh7gxDhTgLjjhYvcDgugpM807p+pq1FX
	xfjRnRKESlfeMbcQRGqwGEEsrwhJ7EuUwsNGIidJs4EdchRZd7W2yeeyS8C1LWVlDl2aI0zWfeI
	XbaaFpuLs9OCkucGdTILYGIJTc/EKnTg=
X-Gm-Gg: ATEYQzydLM5KfYAYTcy5y1gJYSpW5tuHyTgK+8l2/sbS7dtte6r2nDBhkWeO1Fp4MEB
	+jOmntPhed3Ifh1Ii5BA8R2r96kpWsbXool9BskD2BQlRMxoS/HHsZGOZDhH/do/mDq4LfhwS89
	gfXvY/32kaMIaAujB6IBYvCQ4r7kfpHKPMTcd/ofCUYqb4PIWqipuzzHj8Rfm6eB+gcwxExVOj1
	xBY/Nd1sktMnMB2T0I5SO8b5Ko64X7AVtxXIvDYEGEBbvMGPSGELgMDo7ppTbmhxwxf5Tuhl0tu
	qramA6eo
X-Received: by 2002:a05:6808:d47:b0:450:bbed:7a75 with SMTP id
 5614622812f47-46ef7309386mr165326b6e.28.1775152783969; Thu, 02 Apr 2026
 10:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402170641.2082547-1-joonwonkang@google.com> <20260402170641.2082547-2-joonwonkang@google.com>
In-Reply-To: <20260402170641.2082547-2-joonwonkang@google.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Thu, 2 Apr 2026 12:59:32 -0500
X-Gm-Features: AQROBzAmx7Mp6DrgKOrwAcb8k8UUyDzlYzRN_6Wdz-72pTbSanHYGSjh0AuoTJQ
Message-ID: <CABb+yY0ub51k-eFpPfgARXtwYjWzRSjbPDLtoMD77YQR8JH+=Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mailbox: Use per-thread completion to fix wrong
 completion order
To: Joonwon Kang <joonwonkang@google.com>
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233089-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,collabora.com,nvidia.com,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jassisinghbrar@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CB1A38CD0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 12:07=E2=80=AFPM Joonwon Kang <joonwonkang@google.co=
m> wrote:
>
> Previously, a sender thread in mbox_send_message() could be woken up at
> a wrong time in blocking mode. It is because there was only a single
> completion for a channel whereas messages from multiple threads could be
> sent in any order; since the shared completion could be signalled in any
> order, it could wake up a wrong sender thread.
>
> This commit resolves the false wake-up issue with the following changes:
> - Completions are created just as many as the number of concurrent sender
>   threads
> - A completion is created on a sender thread's stack
> - Each slot of the message queue, i.e. `msg_data`, contains a pointer to
>   its target completion
> - tx_tick() signals the completion of the currently active slot of the
>   message queue
>
I think I reviewed it already or is this happening on
one-channel-one-client usage? Because mailbox api does not support
channels shared among multiple clients.

Thanks
Jassi

