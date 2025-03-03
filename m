Return-Path: <stable+bounces-120055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9E5A4BF8E
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 12:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2EA166DA4
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 11:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA9B20D51A;
	Mon,  3 Mar 2025 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="kAdmNOD0"
X-Original-To: stable@vger.kernel.org
Received: from smtpcmd01-g.aruba.it (smtpcmd01-g.aruba.it [62.149.158.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B5620CCFB
	for <stable@vger.kernel.org>; Mon,  3 Mar 2025 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003026; cv=none; b=uxhbOXSMCRPm09BVcHhCcKq1m8ad7doJD+IXu7MIUd7IZeeYfxPpe1j1E6CLY0nDQzxgH8e0yU+rkkWZKUmb5JW5sF2Lal/fZdIfTzmqL1IzvPzmt6VaVKXu3RXLu0r20/5Lj8HL1nosMx5cOqaoRmKEiy/AX8DUS9mXqoP9d9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003026; c=relaxed/simple;
	bh=bdghUzTzBlYu3WkVqq8yLPLahhT013JwLccfoK2GRVk=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:To:
	 In-Reply-To:Content-Type; b=GaHfWfszn5Zr+e8tUg2hNaNfqirx2nBy9XaTLSnMo45mpyVdmzjR9K+eP9Qk0KEQHkB7BDO1VRwllobQ5LX8SAQHPsPEAwLGIGpYnXPvwg7oxsf9S4g2XQxWvJtsIyqv3Cqicaxo9FGLxvOiwpduPZy5Ca8o4rMNJtdIIlgStdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=kAdmNOD0; arc=none smtp.client-ip=62.149.158.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.58] ([79.0.204.227])
	by Aruba SMTP with ESMTPSA
	id p4Mqt0FmRRBkHp4MqtLpYY; Mon, 03 Mar 2025 12:53:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1741002832; bh=bdghUzTzBlYu3WkVqq8yLPLahhT013JwLccfoK2GRVk=;
	h=Date:MIME-Version:Subject:From:To:Content-Type;
	b=kAdmNOD0Xs74JP/X8nKy3Jo8EkKu6S2xNAWrnznOtS/P65bWHvSDNNE62ES5jkpg8
	 B0AoPZFpT6D1RFhcNBotVO9i/ARyHB2WH4NK+viPYv7ZBH1lECLNb6DK8VMdKMFv4s
	 DoA8OHlgf92MHXMvKd1R+sCSF40B5EARaYPNfJcscsvz+omAOC51TOBPnGQWWTrwDn
	 0bNMvOO3FgUUHt7MdBrhBQZ7r2yIsH3ZKIK1lZTY/QWEYBEz0bKO9Urued26ycLMtE
	 Cyw7nM9NSXMiZyGpyQMvC+EN6YI8rLS4fa0xup9cx3njdVj8kT4iNySc+9i6REpiPV
	 2HOJiL+9WZMxQ==
Message-ID: <2738fe1c-4dc7-4d8c-ac8a-f32e5b3277c3@enneenne.com>
Date: Mon, 3 Mar 2025 12:53:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pps: fix poll support
Content-Language: en-US
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Denis OSTERLAND-HEIM <denis.osterland@diehl.com>, stable@vger.kernel.org
References: <561f4dfd4cbd416baee0fb39b5d55aa1@diehl.com>
From: Rodolfo Giometti <giometti@enneenne.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <561f4dfd4cbd416baee0fb39b5d55aa1@diehl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfH3JdXCmmPetYrjaWeMfxxmA0d+9GF7ZCXYv9fGUqHdwqPGvbEEbow2sNGVh6IOrpuZ6i2sEaK+bARZV8pcW7ShcNkzj938iiCx3b3bXH1Ba00d8vlpa
 SCjWS3/Dp00FmDJBYTvA4qcu/OHE227MfTMgBWB+hlxvt2j9P5Vh9DqL5Rf0SOMwrjUy995C1+AugVj/89tATnHwREf6O36oa9sk4CZz6zls5l9cCLLbqV49
 +Ho8PFZERgxoq+1UxKel1BO62U7wswxhkkFfaoFXEoZCws90kZq5aMiqA+cJS3CA0rFHF98Wozyu8Ky+pGf6XBamKjjKbMdnFXc5vTMWTncV/+isbm4ayDNu
 VwdxC3SM

On 03/03/25 09:02, Denis OSTERLAND-HEIM wrote:
> [BUG]
> A user space program that calls select/poll get always an immediate data
> ready-to-read response. As a result the intended use to wait until next
> data becomes ready does not work.
> 
> User space snippet:
> 
>      struct pollfd pollfd = {
>        .fd = open("/dev/pps0", O_RDONLY),
>        .events = POLLIN|POLLERR,
>        .revents = 0 };
>      while(1) {
>        poll(&pollfd, 1, 2000/*ms*/); // returns immediate, but should wait
>        if(revents & EPOLLIN) { // always true
>          struct pps_fdata fdata;
>          memset(&fdata, 0, sizeof(memdata));
>          ioctl(PPS_FETCH, &fdata); // currently fetches data at max speed
>        }
>      }
> 
> [CAUSE]
> pps_cdev_poll() returns unconditionally EPOLLIN.
> 
> [FIX]
> Remember the last fetch event counter and compare this value in
> pps_cdev_poll() with most recent event counter
> and return 0 if they are equal.
> 
> Signed-off-by: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
> Co-developed-by: Rodolfo Giometti <giometti@enneenne.com>
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

If needed. :)

> Fixes: eae9d2ba0cfc ("LinuxPPS: core support")
> CC: stable@vger.linux.org # 5.4+
> ---
>   drivers/pps/pps.c          | 11 +++++++++--
>   include/linux/pps_kernel.h |  1 +
>   2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> index 6a02245ea35f..9463232af8d2 100644
> --- a/drivers/pps/pps.c
> +++ b/drivers/pps/pps.c
> @@ -41,6 +41,9 @@ static __poll_t pps_cdev_poll(struct file *file, poll_table *wait)
>   
>   	poll_wait(file, &pps->queue, wait);
>   
> +	if (pps->last_fetched_ev == pps->last_ev)
> +		return 0;
> +
>   	return EPOLLIN | EPOLLRDNORM;
>   }
>   
> @@ -186,9 +189,11 @@ static long pps_cdev_ioctl(struct file *file,
>   		if (err)
>   			return err;
>   
> -		/* Return the fetched timestamp */
> +		/* Return the fetched timestamp and save last fetched event  */
>   		spin_lock_irq(&pps->lock);
>   
> +		pps->last_fetched_ev = pps->last_ev;
> +
>   		fdata.info.assert_sequence = pps->assert_sequence;
>   		fdata.info.clear_sequence = pps->clear_sequence;
>   		fdata.info.assert_tu = pps->assert_tu;
> @@ -272,9 +277,11 @@ static long pps_cdev_compat_ioctl(struct file *file,
>   		if (err)
>   			return err;
>   
> -		/* Return the fetched timestamp */
> +		/* Return the fetched timestamp and save last fetched event  */
>   		spin_lock_irq(&pps->lock);
>   
> +		pps->last_fetched_ev = pps->last_ev;
> +
>   		compat.info.assert_sequence = pps->assert_sequence;
>   		compat.info.clear_sequence = pps->clear_sequence;
>   		compat.info.current_mode = pps->current_mode;
> diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
> index c7abce28ed29..aab0aebb529e 100644
> --- a/include/linux/pps_kernel.h
> +++ b/include/linux/pps_kernel.h
> @@ -52,6 +52,7 @@ struct pps_device {
>   	int current_mode;			/* PPS mode at event time */
>   
>   	unsigned int last_ev;			/* last PPS event id */
> +	unsigned int last_fetched_ev;		/* last fetched PPS event id */
>   	wait_queue_head_t queue;		/* PPS event queue */
>   
>   	unsigned int id;			/* PPS source unique ID */

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


