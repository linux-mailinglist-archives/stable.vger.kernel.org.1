Return-Path: <stable+bounces-249371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCldOodiC2rwGwUAu9opvQ
	(envelope-from <stable+bounces-249371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:03:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D0F5728BC
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93C45303101E
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D6F38AC9A;
	Mon, 18 May 2026 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IemDGTJJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F223101D0
	for <stable@vger.kernel.org>; Mon, 18 May 2026 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131009; cv=pass; b=jtQIdckz83VjvptM0Dy5TdeHsmDpBIj3K6KH4n+2qx5W43ilBv9FcZ4ew3wt902x0nb8jiVvEROJDf6tjCfLlnwfY72SQHxMSkZ0mj3HRBtnIfHTuxr0qw/RPNDCeVA31z/NILOB4K6Edpd6dGMDFgpHbCzbm2CiAsoJ0TITwVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131009; c=relaxed/simple;
	bh=67HjrRPVZXh3AZFX0Vof7SQ0bSC/071zrZy7s70aQHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+tXzgBZIa72Zw25JR+ZUYcVR0/jOdGUWyu24Ozn62jIqkgiAaUrIWZvZG71iYG7GF+8SNmDrmH3tMyuCk7sj8qktON73y7VZ+MwXqRggvs8+dc5YXTy//t39J8gcic46Gk28dPmf8aqzlWnR9je8uVEz9FyHlhj7yw69772vXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IemDGTJJ; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-479ef2b7979so2043910b6e.3
        for <stable@vger.kernel.org>; Mon, 18 May 2026 12:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779131007; cv=none;
        d=google.com; s=arc-20240605;
        b=TJlrqJEVZu7AuRangZVR6tlVEzusHMbe1NeafUal2qUAn+VPpv49Mt3d0jAgyWpUO5
         6BuDC6cW8X/5LmWl+rEFiieyWEtEiWg1Pa33Y47rFYDtBMvq7hUZ8gMJ951/cX+BYFuB
         E7r01gSom878glz1WYl8+XrBqYsLsTiQp2ABuWICwRuHfwE9s1dkfoxh3VLyziezoiI7
         QsDcAEC9wYIuYCqx1tCVMSbpBVJpAUIlGvnhqQB6BeK9EAGpaCCZ3ICNLo8o82pucQ4h
         s0XIxMSz5zc7Wk6QBTsDJa8ECkihB7EngZjXYRnJPs1RGRf/IGRZoE5oi1Q5BZXUIysY
         69RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dpt9kSjxUzbO+Wq0fLisBu6K/RbAT/jMe9LFJMTygZw=;
        fh=T626rHchT4DjGpL/74Vj1uOx6xd6wTHQZnjkpfbeh/E=;
        b=K4H1M6qsIX4LDWOFPrixxxSsAPCzY3tZy8Xu7cQ5KDpX6Gn/qsVPy15oreNBUu8ndh
         KkA3IfOC36s99eZycX50SvHwLjinmqxi6dAXZGYHKh1fCiwkPOTXElUYk4jjie1631rK
         uFLae1ySjMhlKDo9nYZwx4evH2p09IyPWAsO/GDdUCh9Hkn6OMIad7DxIrFJIXJhbjMD
         7ac+7Y/WL3wOZlYt66motnyGFuRFrg36l2wcLDULh8vJz21KBc1cTO/1/g/ho+V6U2Jb
         4wDe+OQ/TbIEOy1RgQ9xShW82nU8Klca4i4hlldj/tIfgC2YwQV8Mwhz/Qqh6J3XKrsQ
         WsXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779131007; x=1779735807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpt9kSjxUzbO+Wq0fLisBu6K/RbAT/jMe9LFJMTygZw=;
        b=IemDGTJJZM8bFbSLMC7c2eRhdyi57MPuRmDzBl/Es7matn4XY3eOUj6WfXnAamJVWZ
         tK4vvLhNJWa68wQ7zXFYqaXB+S3kbMXk51q3VXWGct4FAU66NxtrO94j511hBmFop2cD
         WVYtHWB54jOS1Wz0BR0zH+ixT/e+xFJKHcbIEjQG4qJoyh+c9hXyuNjQz5Cez+QQDsPh
         HAENY8XPrW1KagUZJVPPlrLRo/Yo+g9QAZ+7ZLNyUPzOijoL25dmm2pVlqFnk5uKipFt
         nKYIAGnnJMxVOD/bepWbCWuFPtmLgpojZPcPhIxF7TcOAtjlA8B7ksTst1OFbF30DfSs
         55uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131007; x=1779735807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dpt9kSjxUzbO+Wq0fLisBu6K/RbAT/jMe9LFJMTygZw=;
        b=PY+MsiwGke4OqIn7VMTYBjg3pxi4MbbHMDK/h3a5782UWePAUsMpyy0kVooayzErF3
         1lgLVY6fDHwn7hppr6l2x5Kl8c8SHBZ2zj9nVruk1vTMNZB32sSyUSM4zXk2PrHTo9lB
         TJz8vKPVlvmE0EPTYGrCV/sAwSUzH5S4DETEcJb3YuSnkfCvdTcyNm8mDKIpXVK0Vjun
         JHNYlMpJp89/Hdcj0DqNoZwwYmn21KBn+EbSGs+fHJllCsNAQxtN3tptbjpme1tCne2x
         84uJWARE/vs7qf01M0Cvgn3SFoAzxwGBHxG6uSBiqpm1Qo2JpKUO8UQB9yb5aV/rnAgW
         MSHA==
X-Forwarded-Encrypted: i=1; AFNElJ+0wvEmgZ3Gy1NzDVwyr8KLM/xmZ9k3Z4m2Xy1zhbv5E9XdSUwtFj6oAJxuD53hZCod+1NCG4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUelTatlz8qPe2CPEew7jZuKMknDxlSSM8/qbBeQWHN7nItfam
	MepjkVvh3rK5Gc9ywNrkp9fyOYL9B/fqBGaRwRCGSZRbM2rVrRhsIuU2aGVezL/rrJlZtkWx0Sv
	z65u1n7jijIz2/UkQot55KRBbR0vN5TM=
X-Gm-Gg: Acq92OExx89TDAl6U1DDyQpN8qmHS6/waFhxQNmiHw/z/EWfg60tkiWVO9eUIIWRnRP
	YFzPKWAcbsHTSHSAby9hyO5AEvYbfdPw6mtRvS95dgDyXX74meCOHKY11i5JarpuOqGxCbD3KRT
	y4IyHo9P8zJ9dmwCL4sJDyjAQdaE7Y5P5lWh5Wfi9CT2xtemJqNSEG5fgKCL8ZWU+ysI+7Tuji3
	medEDnjS35wqIgHyu48j6R8mQFulYyop3s23wUsQzhCTXDQaTAVeaYYsfdVxwTW26cVUEE3az1g
	aD0I8AUx
X-Received: by 2002:a05:6808:524a:b0:482:65b4:4fd6 with SMTP id
 5614622812f47-482e56d4fccmr10934673b6e.20.1779131007252; Mon, 18 May 2026
 12:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421104652.211276-1-joonwonkang@google.com>
In-Reply-To: <20260421104652.211276-1-joonwonkang@google.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Mon, 18 May 2026 14:03:14 -0500
X-Gm-Features: AVHnY4Kdi_G4D-sSUeR-mK5gt0_sbPbGAr6l6lOHZg8W5pSGnwuRDyMfIK9m0Y8
Message-ID: <CABb+yY3KY7oyjiZpQ_p=JTh2v1kBM60EhLPgDGyrXsSy49EmjQ@mail.gmail.com>
Subject: Re: [PATCH] mailbox: Clarify multi-thread is not supported in
 blocking mode
To: Joonwon Kang <joonwonkang@google.com>
Cc: sudeep.holla@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249371-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jassisinghbrar@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 83D0F5728BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 5:46=E2=80=AFAM Joonwon Kang <joonwonkang@google.co=
m> wrote:
>
> Unlike in non-blocking mode, multi-thread has not been supported in
> blocking mode. This commit is to prevent clients from having wrong
> assumption by explicitly specifying this fact to the API doc.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Joonwon Kang <joonwonkang@google.com>
> ---
> v1: Abandon the previous attempts to support multi-thread in blocking
>   mode and instead declare it is not supported.
>
>  drivers/mailbox/mailbox.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index bbc9fd75a95f..b00f7a32e866 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -258,6 +258,10 @@ EXPORT_SYMBOL_GPL(mbox_chan_tx_slots_available);
>   * over the chan, i.e, tx_done() is made.
>   * This function could be called from atomic context as it simply
>   * queues the data and returns a token against the request.
> + *  In blocking mode, it is caller's responsibility to serialize threads=
'
> + * access to a channel if multi-threads are to send messages through the
> + * same channel, i.e. caller should not call this function until any
> + * previous call returns.
>   *
>   * Return: Non-negative integer for successful submission (non-blocking =
mode)
>   *     or transmission over chan (blocking mode).
> --
> 2.54.0.rc1.555.g9c883467ad-goog
>
Documentation fixes don't go to stable, so removed the cc to stable.
Applied to mailbox/for-next
Thanks
Jassi

