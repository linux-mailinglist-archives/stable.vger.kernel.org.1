Return-Path: <stable+bounces-256628-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL+QMlOLGWosxggAu9opvQ
	(envelope-from <stable+bounces-256628-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:49:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7829060276C
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C927730170B9
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48C823C39A;
	Fri, 29 May 2026 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQw04np3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A61323E342
	for <stable@vger.kernel.org>; Fri, 29 May 2026 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058959; cv=none; b=sAJFebYvrG+Ju+BW8SN1cSbCwZo8IWU9jzx6Pc692Emat1zClqYFeDbsLmmuJsfTZcgVDZESqL0Dgxwsignxi8jGixNmiNKiVgVl2/5L55IILK9dS8WCVcRncF53h1pKZ49wr9/q6lt3a/IIo7R8GnKiU3AQ1+Ykm+e2FhZ7mNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058959; c=relaxed/simple;
	bh=o1aNfHq1uozEsSWkvZYZ4Uu4NkcthQtaXLPjQAF+8FY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlvsunhjcEA9b5W7I4lSQltJNbWMmaRcGGLH1KFVpgjwK7mEXtDxRrJ6W/XSJoQ4BN/9GyrF/7PyZDP2jYg4zjYi7WzGm2UtPYBHuxrJmZNuirKx92/36lyUMXxOH1qBrFENALQsd48jmKa/EyjlHszX1ZltsNql750Xw3LLfmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQw04np3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49039a8851fso82859455e9.2
        for <stable@vger.kernel.org>; Fri, 29 May 2026 05:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780058954; x=1780663754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GDkBuC5UsNjEzh9y+dU4msIG/STJQsz4VWpz07Z1rE=;
        b=IQw04np3xkUH8X1m0vyC/KA68XT8buwEr5wY09anqrHW2lGgbHny0Kpz9yyVqzJlQd
         vdMfooIP06MWjYhqWpVax6gAEBb/kvtONdlIkVITetWm38zSIVhJSnG4ovtFPMI/Ps3w
         pCjC2a/n3ZWMUT5VayCLIENIE0l+G4fFszHVo3sEQdK/gxstJcA2H7ohgj5DY1Vgm78e
         vSiTCkcu/D+fNSWY1G9mTu11kXth4pVslItyqwhpzfhldUzqtt+YixNXzM3j3gjCio6U
         mgUZiEaGZ2I6Gz5qI3d9fkLttNUPg3fdF0M1c64OMWkvbOlBvp7rTaVqMzXnynCIYS5o
         VzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780058954; x=1780663754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8GDkBuC5UsNjEzh9y+dU4msIG/STJQsz4VWpz07Z1rE=;
        b=qH6etLibWe4Ml/XPn/MLZwl1+3QdjUsGR8aA7uzF9wvR5eEOG2qbthrAemLxsgFPzH
         SfBF+qqaCbqmgfTqnEOqOUJiVUCGdipq7rBOqPyt79vdaG1cURURzSimb7lnq9LzY2mB
         sV8NnSQXlauwCFu4RI29O8qoYZ88AsNY/4halaw/RafLo8PuY1XPz2VRMTAFMqykRMqN
         03hDjNngfJKr9OrjgT1oExpS1dbiQlyVOjZya0h1m4JJF8u1uPMmZjrmUZx7H3dNhmr/
         ZhyQEXRYGFtDqfJ1Skh/e9n7OV2WVNfm9LWr65eedao4Z4HMPzVdK1q1+AuZC1dCq/ir
         Ykcw==
X-Gm-Message-State: AOJu0YxAUWwIV8vRgNUgbE4N1jK4NN8gJIL49/iDiYdVBZWhV06JMSx9
	bme4Y+XTTpcPJVwyAuQoiScimDySo1t07EPC2ytaGoDxnX77H9IxRKJpVD4VGucz
X-Gm-Gg: Acq92OFK8oOodgfS3pI/TQVonhobE5Y/qcBKlcY0Ek/zyOeus1UgXarUChUL2z0WPoQ
	QqeiUX7HkcOptbxxzVjCWBemiu4/0AjrhG0tBeHVZjfBdG6ikUrBqu91CKHp1qnnsmZCnCTQaD4
	2BIZv1Pu8UCw+sqsHybEMYvVM2z+H3h7w7u5McCLw5ikbGnEQVqwO9Hx4xzwYW8dmHtuOgN7MEp
	qnFfZ7T69rp9KMLml/F7CnRFp0Ec/sztXdBEV3LNHXxeajyIJKeQ8cRYU+FbJQcgt7skRiSC48k
	CsjyehouGpYs8QOhX8MOmwN9OvX5EjrfUHjr6mneiq7/l9gEeMov97+Yv7dXYiLPaq7Vf9LpFEp
	g7zly2Bxp1Me6+MOHDEZR2zr7NnQO+MIgwPcdg2ETYIYhQqaq2F6c8SpFlzjyF8LnZ9Rfb2hpZ2
	VTpZHiZxVjcWKgkhKKshYAC4jKtAyvAyci14oBwUqkPnA5EkyYpNEiBEJIoGjNZ7qrn35TUzI=
X-Received: by 2002:a05:600c:8508:b0:48f:e230:80a2 with SMTP id 5b1f17b1804b1-4909c0ce6bfmr51557605e9.32.1780058954425;
        Fri, 29 May 2026 05:49:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c1049f8sm13781475e9.18.2026.05.29.05.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 05:49:14 -0700 (PDT)
Date: Fri, 29 May 2026 13:49:11 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] accel/ivpu: Fix signed integer truncation in IPC
 receive
Message-ID: <20260529134911.40728b88@pumpkin>
In-Reply-To: <20260529115005.131888-1-andrzej.kacprowski@linux.intel.com>
References: <20260529115005.131888-1-andrzej.kacprowski@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256628-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 7829060276C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 29 May 2026 13:50:05 +0200
Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com> wrote:

> Fix potential buffer overflow where firmware-supplied data_size is cast
> to signed int before being used in min_t(). Large unsigned values
> (>= 0x80000000) become negative, causing unsigned wraparound and  
> oversized memcpy operations that can overflow the stack buffer.
> 
> Change min_t(int, ...) to min_t(u32, ...) to ensure large values are
> properly clamped instead of becoming negative.

Just use min(), no need for the casts that min_t() adds.

This is another (slightly unusual) example of why min_t() is broken.
Even with min() doing strict type checks the correct fix would have been to
use (u32)sizeof(*jsm_msg) - and completely ignore what checkpatch says.

-- David

> 
> Fixes: 3b434a3445ff ("accel/ivpu: Use threaded IRQ to handle JOB done messages")
> Cc: <stable@vger.kernel.org> # v6.18+
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> ---
>  drivers/accel/ivpu/ivpu_ipc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
> index f47df092bb0d..9980a7898bed 100644
> --- a/drivers/accel/ivpu/ivpu_ipc.c
> +++ b/drivers/accel/ivpu/ivpu_ipc.c
> @@ -276,7 +276,7 @@ int ivpu_ipc_receive(struct ivpu_device *vdev, struct ivpu_ipc_consumer *cons,
>  	if (ipc_buf)
>  		memcpy(ipc_buf, rx_msg->ipc_hdr, sizeof(*ipc_buf));
>  	if (rx_msg->jsm_msg) {
> -		u32 size = min_t(int, rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
> +		u32 size = min_t(u32, rx_msg->ipc_hdr->data_size, sizeof(*jsm_msg));
>  
>  		if (rx_msg->jsm_msg->result != VPU_JSM_STATUS_SUCCESS) {
>  			ivpu_err(vdev, "IPC resp result error: %d\n", rx_msg->jsm_msg->result);


