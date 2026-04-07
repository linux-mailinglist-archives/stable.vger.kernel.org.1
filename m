Return-Path: <stable+bounces-233486-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGR3I/xp1GlQtwcAu9opvQ
	(envelope-from <stable+bounces-233486-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 04:20:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FF53A8F6D
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 04:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59B573012EBD
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 02:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EC234D90D;
	Tue,  7 Apr 2026 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="OxPO+iRc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A217993
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775528441; cv=none; b=qg3R5xsw0UgpEc3vEAnxNJCcCAOe6k/IMrCB3CbdNOKcR7RB3aT139h9Kdeq2HpncMr3R7TYp3YMgqGO3KgxWqkIAndfLlfQxuJsn/Jfa67LZZWl1WPdLdx3bsOmibGg8D9DR1iJOiuoreNrlqE4prf01ZhRdgLtKdTA9XpwrCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775528441; c=relaxed/simple;
	bh=LNl598CtverB6RoVHWavFb380/eHEY1x3g4dSUTb7wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZsVLXCYd7nwIOVeWPPZ/p5v0f1DBYMq3hHWa6RBccIqaLbF1Z6DkmTYkoT8PFVocpIMetkZ8d2Y5y64E5stQbT7SR0xZRyS4mqEmXUtRfrMnVkknOZIm/sU1FAEezeEIY7TV15gYDPm0z3he/UNHq1ENSNyVVCAmmTnTmC6sls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=OxPO+iRc; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d86eb7c854so2345894a34.3
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 19:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775528437; x=1776133237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uj0K5FyMi7XSuPG2uq1mtZavJKlMVDQzSk2zMk1W2/0=;
        b=OxPO+iRcqVzb8MVjEBWVVtlbaMR+C4ZsG8PF/PkyZO6VTgPF1mjkBSqQ2byFfUPIzq
         aEFD/QWtR70y3xY9CEIOFHKt1PbD8YLQ46QQxTAeNADOjNvkqg9wFOtT6PNrPNNGgSeG
         O+hRZCypfjpoQ9MxxUNJL2+X9W+jcj0ZSg3iPseVAAuIRH0+1RPuQTW4nLwDz4z9fbMU
         JU2jw/1TBl4TM01f2P8/4arolVBxh5eVRydbKOQv6pAycaQu5IEO3Jg2vyLtAIFrBqkA
         PvCgZHb4oo/vvzUZToM92Zom3pc67Jnan1mUrAuePotpjDKZCBBd1KB1ljFcqmXUxN+E
         9LaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775528437; x=1776133237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uj0K5FyMi7XSuPG2uq1mtZavJKlMVDQzSk2zMk1W2/0=;
        b=s1B1atRylWjI3vpLJ0N27pFtCLSj/xVP296qDm845eGLEb4wbJoNkq2msZzlTMvbqe
         pV0B2ypSXkUR9biHiM2Ho8UXEMPy/PHnWO6sBJuIVexnuaMclSzgHDZjxTFurL8X1JTb
         7J0StRQOiPOAkuqhG8Xhd6c+H61r4gyy4Tp0YxTaOM9xnHiyJHg0Cgb2Ktw+VFkMO2gH
         wwxSG3eQQd+1cr5zMVSjyIwUCc4kWtHCkFc/9dQeZUHaDSF+yaxMwGeVCn591Id02Kcs
         z2QXB1nFxx0j5dKwSxzBVYBs4Qw8v2c7fc5YYLd2pgyIDSion1twzIXfzHWInOK2Mm51
         KOjA==
X-Forwarded-Encrypted: i=1; AJvYcCUcEzhr2PKtst41fsbZ1Mdjp+hD2wiHpyc5lYjpOiWMTue9yJOktr9qJ+LI9p2hQiTvuV0FzTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4TlrTlXwwo3pFJa0gGYLMUgZq6mNSHrbQA1C4T7YlBVLBkveY
	VwkDWaEmewR5TxHuSadBQoWybJuONtho8e6EtEgjJ0en1ncGnFaA6QpiKdO9UDS1bt4=
X-Gm-Gg: AeBDiesDd2g7HNKNvQ2dhfG/aACB574hFIRJ+zJygK1Sg2vWIJUiecRWAESQU/WjRAo
	icU1TZGD2yl10iRD2zxOPFOylOJ4NZB2qdYdOg4MH9ADLza4/Yr0du02GLTK+Uw9OQAct4v3CmG
	xoV1mcCLgbPNUKFyNbE2l+hLTNa25wDO1SCpDd3kBGt2Hrq8MOniiUHAWN84Ev143PTBoCVpQR/
	c+VuIirhNj0KzB5HH435an+TVwIKXMLy2FCX/fm3E6PYQ0PkGYfeRRWlYVWhWG7T7fJ6QJCcV8E
	XyhdAkkNE7xT8pwwWl7BEl4h1HKRK7vbl3nI7mM2ehiGTRR5ecJDkugOtD6tjCvj+SsiXqIK0RN
	ZKKdbE66fQ+KtnxDTVZ6Kc/SKH2Vh/OBigJBqBwEhjIgn+LhJFXFshDi4vFeda206KGOXOJ8hqu
	1V6hFPyG+fLP9wOgGIH6elRO++UsO8fYtUQrHoUE6i5fwq79i+9u9xAym301Y3D9lPDo0wI0qzl
	cXnPdf9rw==
X-Received: by 2002:a05:6830:83af:b0:7db:b68f:b819 with SMTP id 46e09a7af769-7dbb6f25a6emr9575077a34.6.1775528437568;
        Mon, 06 Apr 2026 19:20:37 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbd663a4a5sm4895363a34.25.2026.04.06.19.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 19:20:37 -0700 (PDT)
Message-ID: <8143e057-4c3b-4365-8780-003e897b9baf@kernel.dk>
Date: Mon, 6 Apr 2026 20:20:35 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-apple: drop invalid put of admin queue reference
 count
To: Fedor Pchelkin <pchelkin@ispras.ru>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, "Heyne, Maximilian" <mheyne@amazon.de>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20260403202701.991276-1-pchelkin@ispras.ru>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260403202701.991276-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-233486-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 02FF53A8F6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 2:27 PM, Fedor Pchelkin wrote:
> Commit 03b3bcd319b3 ("nvme: fix admin request_queue lifetime") moved the
> admin queue reference ->put call into nvme_free_ctrl() - a controller
> device release callback performed for every nvme driver doing
> nvme_init_ctrl().
> 
> nvme-apple sets refcount of the admin queue to 1 at allocation during the
> probe function and then puts it twice now:
> 
> nvme_free_ctrl()
>   blk_put_queue(ctrl->admin_q) // #1
>   ->free_ctrl()
>     apple_nvme_free_ctrl()
>       blk_put_queue(anv->ctrl.admin_q) // #2
> 
> Note that there is a commit 941f7298c70c ("nvme-apple: remove an extra
> queue reference") which intended to drop having an extra admin queue
> reference.  Looks like at that moment it accidentally fixed a refcount
> leak, which existed since the driver's introduction.  There were an
> initial ->set and an extra ->get call at driver's probe function, and only
> a single ->put inside apple_nvme_free_ctrl().
> 
> However now after commit 03b3bcd319b3 ("nvme: fix admin request_queue
> lifetime") the refcount is imbalanced again.  Fix it by removing extra
> ->put call from apple_nvme_free_ctrl().  Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 03b3bcd319b3 ("nvme: fix admin request_queue lifetime")
> Cc: stable@vger.kernel.org # depends on 941f7298c70c
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
> 
> Also nvme-apple seems not to have a blk_mq_destroy_queue() call for
> admin queue since introduction - if it's needed, the proper place would
> be in apple_nvme_remove() just before calling nvme_uninit_ctrl(), I guess?
> 
>  drivers/nvme/host/apple.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index ed61b97fde59..1d82f0541b0b 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1269,8 +1269,6 @@ static void apple_nvme_free_ctrl(struct nvme_ctrl *ctrl)
>  {
>  	struct apple_nvme *anv = ctrl_to_apple_nvme(ctrl);
>  
> -	if (anv->ctrl.admin_q)
> -		blk_put_queue(anv->ctrl.admin_q);
>  	put_device(anv->dev);
>  }

Could this just be:

static void apple_nvme_free_ctrl(struct nvme_ctrl *ctrl)
{
	put_device(ctrl->dev);
}

at this point?

-- 
Jens Axboe

