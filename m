Return-Path: <stable+bounces-19340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C09B84EDA5
	for <lists+stable@lfdr.de>; Fri,  9 Feb 2024 00:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80AAA1C213B0
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 23:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B47852F9D;
	Thu,  8 Feb 2024 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pBTgpJeW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35039535AD
	for <stable@vger.kernel.org>; Thu,  8 Feb 2024 23:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434200; cv=none; b=Kf2D/qNLdtYkVRE+lb/O7veyLzs7z5u7lg/mgedg4G2wg5Az8fG62HfNxuzxv+nKnZFbcZ6og9VdFO46qBxAP6QSIpna6tdcawLAa36xJYMp/CMDM5BzCkckSVpFeHHATE2K9qA9siHbzaFzcaW1ZO5YJgAUw2wJqGaZfsrTmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434200; c=relaxed/simple;
	bh=2bGJLzFhFfCIUPKaSQUDp4Mckew63fsETmbhuTJEWik=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VvESxk+8POVKtSxNFVR8wzYEJ1BG8xARDrOWQDCDQXpcpji7pHe+6SzVGaVZUiTvU/iy1e371d/Lf4gA7tRN1QZ0dajX4mMXbyQnENU+CASD4xK0KaNeyXCIdfzFznx9+UL4l2P7NshBWwRt9QL4JVyqB4gpw1FoGp/KIqXyVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pBTgpJeW; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cfb8126375so44007a12.1
        for <stable@vger.kernel.org>; Thu, 08 Feb 2024 15:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707434197; x=1708038997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5qgHx2LgS4bY+0PPCokztMHDhZZRS02N7E3ZS5OqO9E=;
        b=pBTgpJeWFu93RjOtNklTDs5vZruQLmnowx3CymeYCdjy4HvlD91CiGrZGmSbKFUxbL
         r2RkG+qvTbTc1jqYlnSiF7psDYZWQMvJDnrEw84RJszkG3AQ4qze9sqRic4w8PKr1tyB
         AB1SsPKT+itunzPL9HlvfTgZi99z1D86ylIIdf1x2/1XNsOYX9GUZMlQVLuxO36dimxx
         9flRi44y2fVk2xF/neGEvrdziuCe9nRqMBlmcr9JboN91D7jX/gv77fzDy7B1pJqlXbu
         Iom2CaCTTKhXpXQ66/No8b6kw+Eh0bX5rA134fdpg8/rNYiEqZdKJlDiXoL74czYIh1g
         rH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707434197; x=1708038997;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qgHx2LgS4bY+0PPCokztMHDhZZRS02N7E3ZS5OqO9E=;
        b=OJTGNKfHzd9zGPHSFtZ4ZK89i/SGAiHthq1S9QaKQ/7V0KqBjchdt0GXLwCEOLmNnn
         nVR+/iVOdL0F2j13O62niP6bmsAIQIDjqEp+q3B+FMAeIGdeD5dkBLHuFLfGZqdzHzJq
         DcAynpg3AqWKM9RW2MR1/oIaj07DikZViwTHaptt31qOrTtWqNWw0oGXBbk5MRO1K9rw
         XziwijMKl39I1rNVTogqCYevXkXOhFWTbF0vf17tR6Jt05umxDeHgAaaEzdjuHYAdGb4
         5D7S9xlOQVMo+mxREdDwtAubmC3SoVjdeV93wHrld29lp3Y3ApMo8nZ1s91YOZhF4XtS
         UQzw==
X-Forwarded-Encrypted: i=1; AJvYcCX9H3A+IZr4KKPnwaLG9jacrFl1Euz3ycz81mdsjmODdOhPxVLj4v5RCtR5TD8fq08mOXILQE4ZyLOS6ZrcgBHrhk6IDGLV
X-Gm-Message-State: AOJu0Ywi5Vt3pPIfiw2RdPFiEByEWqHQPUVNQbFKLs4atixjvRIxOTAp
	CrmrixqC9P4zhY/fwzwocebxw0odlFFlRJsZ0GRea18yZoFEdxc1D1TMpVCUjwU=
X-Google-Smtp-Source: AGHT+IGEst5SiDs9mAQplgj4h6yqFIjCrEXQxSJBl4c8xpEBEi3VMU9hY0v7ubhAXBNencKELjWAzQ==
X-Received: by 2002:aa7:8890:0:b0:6e0:84d4:e029 with SMTP id z16-20020aa78890000000b006e084d4e029mr395004pfe.3.1707434197414;
        Thu, 08 Feb 2024 15:16:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3FkVCD9AoYJ8SHVTNL0q8dn71aT/iDfoL3KpsDe0gOkBwJydbRaWMYl7/kJMCXAF9KuUP8XuX8C/GCS2joFsDlLsuPA3ixUBm+R16b42ciPhNvIybRRWWbsUgPlmcWPTUb/xj5hKeKHgAFAKN4Ny6ceOO7UUpCOZgErTrzcqorBj8vXtV607tHkDnGoJzqR2We6dm1vxDnSCuDVvYpdsiDlIM2T+hFwujfIncPPs9lU6uDcx8c8gUfWHUyO2vlWi6
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id p26-20020aa79e9a000000b006e04553a4c5sm314975pfq.52.2024.02.08.15.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 15:16:36 -0800 (PST)
Message-ID: <724fc5cd-aaeb-4c85-abb7-b95f7d476c7f@kernel.dk>
Date: Thu, 8 Feb 2024 16:16:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs, USB gadget: Rework kiocb cancellation
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Avi Kivity <avi@scylladb.com>, Sandeep Dhavale <dhavale@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20240208215518.1361570-1-bvanassche@acm.org>
 <9e83c34a-63ab-47ea-9c06-14303dbbeaa9@kernel.dk>
 <e71501ce-6fb9-42bc-89aa-fcf5d0384c9b@acm.org>
 <184bf1b2-0626-4994-85f4-41fc4f71b956@kernel.dk>
In-Reply-To: <184bf1b2-0626-4994-85f4-41fc4f71b956@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/8/24 4:05 PM, Jens Axboe wrote:
> On 2/8/24 3:41 PM, Bart Van Assche wrote:
>>> Just move the function higher up? It doesn't have any dependencies.
>>
>> aio_cancel_and_del() calls aio_poll_cancel(). aio_poll_cancel() calls
>> poll_iocb_lock_wq(). poll_iocb_lock_wq() is defined below the first call of
>> aio_cancel_and_del(). It's probably possible to get rid of that function
>> declaration but a nontrivial amount of code would have to be moved.
> 
> Ah yes, I mixed it up with the cancel add helper. Forward decl is fine
> then, keeps the patch smaller for backporting too.
> 
>>>> +{
>>>> +    void (*cancel_kiocb)(struct kiocb *) =
>>>> +        req->rw.ki_filp->f_op->cancel_kiocb;
>>>> +    struct kioctx *ctx = req->ki_ctx;
>>>> +
>>>> +    lockdep_assert_held(&ctx->ctx_lock);
>>>> +
>>>> +    switch (req->ki_opcode) {
>>>> +    case IOCB_CMD_PREAD:
>>>> +    case IOCB_CMD_PWRITE:
>>>> +    case IOCB_CMD_PREADV:
>>>> +    case IOCB_CMD_PWRITEV:
>>>> +        if (cancel_kiocb)
>>>> +            cancel_kiocb(&req->rw);
>>>> +        break;
>>>> +    case IOCB_CMD_FSYNC:
>>>> +    case IOCB_CMD_FDSYNC:
>>>> +        break;
>>>> +    case IOCB_CMD_POLL:
>>>> +        aio_poll_cancel(req);
>>>> +        break;
>>>> +    default:
>>>> +        WARN_ONCE(true, "invalid aio operation %d\n", req->ki_opcode);
>>>> +    }
>>>> +
>>>> +    list_del_init(&req->ki_list);
>>>> +}
>>>
>>> Why don't you just keep ki_cancel() and just change it to a void return
>>> that takes an aio_kiocb? Then you don't need this odd switch, or adding
>>> an opcode field just for this. That seems cleaner.
>>
>> Keeping .ki_cancel() means that it must be set before I/O starts and
>> only if the I/O is submitted by libaio. That would require an approach
>> to recognize whether or not a struct kiocb is embedded in struct
>> aio_kiocb, e.g. the patch that you posted as a reply on version one of
>> this patch. Does anyone else want to comment on this?
> 
> Maybe I wasn't clear, but this is in aio_req. You already add an opcode
> in there, only to then add a switch here based on that opcode. Just have
> a cancel callback which takes aio_req as an argument. For POLL, this can
> be aio_poll_cancel(). Add a wrapper for read/write which then calls 
> req->rw.ki_filp->f_op->cancel_kiocb(&req->rw); Then the above can
> become:
> 
> aio_rw_cancel(req)
> {
> 	void (*cancel_kiocb)(struct kiocb *) =
> 		req->rw.ki_filp->f_op->cancel_kiocb;
> 
> 	cancel_kiocb(&req->rw);
> }
> 
> aio_read()
> {
> 	...
> 	req->cancel = aio_rw_cancel;
> 	...
> }
> 
> static void aio_cancel_and_del(struct aio_kiocb *req)
> {
> 	void (*cancel_kiocb)(struct kiocb *) =
> 		req->rw.ki_filp->f_op->cancel_kiocb;
> 	struct kioctx *ctx = req->ki_ctx;
> 
> 	lockdep_assert_held(&ctx->ctx_lock);
> 	if (req->cancel)
> 		req->cancel(req);
> 	list_del_init(&req->ki_list);
> }
> 
> or something like that. fsync/fdsync clears ->cancel() to NULL, poll
> sets it to aio_poll_cancel(), and read/write like the above.

Totally untested incremental. I think this is cleaner, and it's less
code too.

diff --git a/fs/aio.c b/fs/aio.c
index 9dc0be703aa6..a7770f59269f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -202,6 +202,8 @@ struct aio_kiocb {
 		struct poll_iocb	poll;
 	};
 
+	void (*ki_cancel)(struct aio_kiocb *);
+
 	struct kioctx		*ki_ctx;
 
 	struct io_event		ki_res;
@@ -210,8 +212,6 @@ struct aio_kiocb {
 						 * for cancellation */
 	refcount_t		ki_refcnt;
 
-	u16			ki_opcode;	/* IOCB_CMD_* */
-
 	/*
 	 * If the aio_resfd field of the userspace iocb is not zero,
 	 * this is the underlying eventfd context to deliver events to.
@@ -1576,6 +1576,11 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 	}
 }
 
+static void aio_rw_cancel(struct aio_kiocb *req)
+{
+	iocb->ki_filp->f_op->cancel_kiocb(iocb);
+}
+
 static int aio_read(struct kiocb *req, const struct iocb *iocb,
 			bool vectored, bool compat)
 {
@@ -1722,50 +1727,14 @@ static void poll_iocb_unlock_wq(struct poll_iocb *req)
 	rcu_read_unlock();
 }
 
-/* Must be called only for IOCB_CMD_POLL requests. */
-static void aio_poll_cancel(struct aio_kiocb *aiocb)
-{
-	struct poll_iocb *req = &aiocb->poll;
-	struct kioctx *ctx = aiocb->ki_ctx;
-
-	lockdep_assert_held(&ctx->ctx_lock);
-
-	if (!poll_iocb_lock_wq(req))
-		return;
-
-	WRITE_ONCE(req->cancelled, true);
-	if (!req->work_scheduled) {
-		schedule_work(&aiocb->poll.work);
-		req->work_scheduled = true;
-	}
-	poll_iocb_unlock_wq(req);
-}
-
 static void aio_cancel_and_del(struct aio_kiocb *req)
 {
-	void (*cancel_kiocb)(struct kiocb *) =
-		req->rw.ki_filp->f_op->cancel_kiocb;
 	struct kioctx *ctx = req->ki_ctx;
 
 	lockdep_assert_held(&ctx->ctx_lock);
 
-	switch (req->ki_opcode) {
-	case IOCB_CMD_PREAD:
-	case IOCB_CMD_PWRITE:
-	case IOCB_CMD_PREADV:
-	case IOCB_CMD_PWRITEV:
-		if (cancel_kiocb)
-			cancel_kiocb(&req->rw);
-		break;
-	case IOCB_CMD_FSYNC:
-	case IOCB_CMD_FDSYNC:
-		break;
-	case IOCB_CMD_POLL:
-		aio_poll_cancel(req);
-		break;
-	default:
-		WARN_ONCE(true, "invalid aio operation %d\n", req->ki_opcode);
-	}
+	if (req->ki_cancel)
+		req->ki_cancel(req);
 
 	list_del_init(&req->ki_list);
 }
@@ -1922,6 +1891,25 @@ aio_poll_queue_proc(struct file *file, struct wait_queue_head *head,
 	add_wait_queue(head, &pt->iocb->poll.wait);
 }
 
+/* Must be called only for IOCB_CMD_POLL requests. */
+static void aio_poll_cancel(struct aio_kiocb *aiocb)
+{
+	struct poll_iocb *req = &aiocb->poll;
+	struct kioctx *ctx = aiocb->ki_ctx;
+
+	lockdep_assert_held(&ctx->ctx_lock);
+
+	if (!poll_iocb_lock_wq(req))
+		return;
+
+	WRITE_ONCE(req->cancelled, true);
+	if (!req->work_scheduled) {
+		schedule_work(&aiocb->poll.work);
+		req->work_scheduled = true;
+	}
+	poll_iocb_unlock_wq(req);
+}
+
 static int aio_poll(struct aio_kiocb *aiocb, const struct iocb *iocb)
 {
 	struct kioctx *ctx = aiocb->ki_ctx;
@@ -2028,23 +2016,27 @@ static int __io_submit_one(struct kioctx *ctx, const struct iocb *iocb,
 	req->ki_res.data = iocb->aio_data;
 	req->ki_res.res = 0;
 	req->ki_res.res2 = 0;
-
-	req->ki_opcode = iocb->aio_lio_opcode;
+	req->ki_cancel = NULL;
 
 	switch (iocb->aio_lio_opcode) {
 	case IOCB_CMD_PREAD:
+		req->ki_cancel = aio_rw_cancel;
 		return aio_read(&req->rw, iocb, false, compat);
 	case IOCB_CMD_PWRITE:
+		req->ki_cancel = aio_rw_cancel;
 		return aio_write(&req->rw, iocb, false, compat);
 	case IOCB_CMD_PREADV:
+		req->ki_cancel = aio_rw_cancel;
 		return aio_read(&req->rw, iocb, true, compat);
 	case IOCB_CMD_PWRITEV:
+		req->ki_cancel = aio_rw_cancel;
 		return aio_write(&req->rw, iocb, true, compat);
 	case IOCB_CMD_FSYNC:
 		return aio_fsync(&req->fsync, iocb, false);
 	case IOCB_CMD_FDSYNC:
 		return aio_fsync(&req->fsync, iocb, true);
 	case IOCB_CMD_POLL:
+		req->ki_cancel = aio_poll_cancel;
 		return aio_poll(req, iocb);
 	default:
 		pr_debug("invalid aio operation %d\n", iocb->aio_lio_opcode);

-- 
Jens Axboe


