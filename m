Return-Path: <stable+bounces-128817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A06AA7F3DF
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 07:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C63216BD94
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 05:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132D81B21AA;
	Tue,  8 Apr 2025 05:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="dya0aTww"
X-Original-To: stable@vger.kernel.org
Received: from out0-212.mail.aliyun.com (out0-212.mail.aliyun.com [140.205.0.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951112F5E;
	Tue,  8 Apr 2025 05:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744088464; cv=none; b=kTOQUa8o2N+ck/tSZc65yS7Yz1UaRaZg6Pom+LM6QhpLv0cmz9s88cwIvWbDTCdb9ON3xdY426Px01J5Hq5BP+azTMzlZokq459JeDuuwyZjdoi2N30FTRGA+tvvKEY4bDiHpVp2/y53WrUrnAN4NZZJiaRvV4foGe+H/sP4Bio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744088464; c=relaxed/simple;
	bh=czZDnMFSnzWfds0qI1KG8y1eD/T8h4GXl9q2qVkHNs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okzWq7Va77fFuE9LzD4nUCGkh8FUNTu3YdOGLfU6ZWFmGliI5gVi909Ci6dEHcQPFRWfa2Ol2u+rA/dV7gCxOac3Lxfbx1lsgmdOnvdvQcFO6bOIocvbvXghSqLc4sPBt+BFGTEDIN9xgYyGBh5t1oTg5yoT/zkrp3gOf7T4WGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=dya0aTww; arc=none smtp.client-ip=140.205.0.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1744088458; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FVk1eTGXVWxw3i4OEda44NwW29chjqvlqWUvewaxbH8=;
	b=dya0aTww9iVTd3ERtk7n8UVmyyX0eyiNKWz1ZGRyBE7xFylWBEgzUjn0Xy3NWfe2sN7WvRnE9VXQ0JXpkyQ3BMgPDrdz9C4XcRmFbOvtzK4xkkYimkSXt7qEc1/Xji847bm3REdRfG3n8Qoj95r79LlK0zEyLAAi6x+1o3MOU1U=
Received: from 30.174.97.68(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.cGPMUZX_1744086594 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 12:30:00 +0800
Message-ID: <ffa0b6af-523d-4e3e-9952-92f5b04b82b3@antgroup.com>
Date: Tue, 08 Apr 2025 12:29:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.14 25/31] um: Switch to the pthread-based helper
 in sigio workaround
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 linux-um@lists.infradead.org
References: <20250407181054.3177479-1-sashal@kernel.org>
 <20250407181054.3177479-25-sashal@kernel.org>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20250407181054.3177479-25-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/4/8 02:10, Sasha Levin wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
> 
> [ Upstream commit d295beeed2552a987796d627ba7d0985b1e2d72f ]
> 
> The write_sigio thread and UML kernel thread share the same errno,
> which can lead to conflicts when both call syscalls concurrently.
> Switch to the pthread-based helper to address this issue.
> 
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> Link: https://patch.msgid.link/20250319135523.97050-4-tiwei.btw@antgroup.com
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/um/os-Linux/sigio.c | 44 +++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 25 deletions(-)

This patch depends on the helpers introduced by the below patch:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4f087eafdcef24b7160b097ddb9704084767b77a

So it can't be backported to the stable branch alone. Please drop
it. It is more of a preparation for the new features to be added
in the future. If it turns out later that it is also necessary for
the stable branch, I will submit a separate patchset specifically
targeting it.

Regards,
Tiwei

> 
> diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
> index 9aac8def4d635..61b348a2ea974 100644
> --- a/arch/um/os-Linux/sigio.c
> +++ b/arch/um/os-Linux/sigio.c
> @@ -21,8 +21,7 @@
>   * Protected by sigio_lock(), also used by sigio_cleanup, which is an
>   * exitcall.
>   */
> -static int write_sigio_pid = -1;
> -static unsigned long write_sigio_stack;
> +static struct os_helper_thread *write_sigio_td;
>  
>  /*
>   * These arrays are initialized before the sigio thread is started, and
> @@ -48,15 +47,15 @@ static struct pollfds current_poll;
>  static struct pollfds next_poll;
>  static struct pollfds all_sigio_fds;
>  
> -static int write_sigio_thread(void *unused)
> +static void *write_sigio_thread(void *unused)
>  {
>  	struct pollfds *fds, tmp;
>  	struct pollfd *p;
>  	int i, n, respond_fd;
>  	char c;
>  
> -	os_set_pdeathsig();
> -	os_fix_helper_signals();
> +	os_fix_helper_thread_signals();
> +
>  	fds = &current_poll;
>  	while (1) {
>  		n = poll(fds->poll, fds->used, -1);
> @@ -98,7 +97,7 @@ static int write_sigio_thread(void *unused)
>  		}
>  	}
>  
> -	return 0;
> +	return NULL;
>  }
>  
>  static int need_poll(struct pollfds *polls, int n)
> @@ -152,11 +151,10 @@ static void update_thread(void)
>  	return;
>   fail:
>  	/* Critical section start */
> -	if (write_sigio_pid != -1) {
> -		os_kill_process(write_sigio_pid, 1);
> -		free_stack(write_sigio_stack, 0);
> +	if (write_sigio_td) {
> +		os_kill_helper_thread(write_sigio_td);
> +		write_sigio_td = NULL;
>  	}
> -	write_sigio_pid = -1;
>  	close(sigio_private[0]);
>  	close(sigio_private[1]);
>  	close(write_sigio_fds[0]);
> @@ -220,7 +218,7 @@ int __ignore_sigio_fd(int fd)
>  	 * sigio_cleanup has already run, then update_thread will hang
>  	 * or fail because the thread is no longer running.
>  	 */
> -	if (write_sigio_pid == -1)
> +	if (!write_sigio_td)
>  		return -EIO;
>  
>  	for (i = 0; i < current_poll.used; i++) {
> @@ -279,14 +277,14 @@ static void write_sigio_workaround(void)
>  	int err;
>  	int l_write_sigio_fds[2];
>  	int l_sigio_private[2];
> -	int l_write_sigio_pid;
> +	struct os_helper_thread *l_write_sigio_td;
>  
>  	/* We call this *tons* of times - and most ones we must just fail. */
>  	sigio_lock();
> -	l_write_sigio_pid = write_sigio_pid;
> +	l_write_sigio_td = write_sigio_td;
>  	sigio_unlock();
>  
> -	if (l_write_sigio_pid != -1)
> +	if (l_write_sigio_td)
>  		return;
>  
>  	err = os_pipe(l_write_sigio_fds, 1, 1);
> @@ -312,7 +310,7 @@ static void write_sigio_workaround(void)
>  	 * Did we race? Don't try to optimize this, please, it's not so likely
>  	 * to happen, and no more than once at the boot.
>  	 */
> -	if (write_sigio_pid != -1)
> +	if (write_sigio_td)
>  		goto out_free;
>  
>  	current_poll = ((struct pollfds) { .poll 	= p,
> @@ -325,18 +323,15 @@ static void write_sigio_workaround(void)
>  	memcpy(write_sigio_fds, l_write_sigio_fds, sizeof(l_write_sigio_fds));
>  	memcpy(sigio_private, l_sigio_private, sizeof(l_sigio_private));
>  
> -	write_sigio_pid = run_helper_thread(write_sigio_thread, NULL,
> -					    CLONE_FILES | CLONE_VM,
> -					    &write_sigio_stack);
> -
> -	if (write_sigio_pid < 0)
> +	err = os_run_helper_thread(&write_sigio_td, write_sigio_thread, NULL);
> +	if (err < 0)
>  		goto out_clear;
>  
>  	sigio_unlock();
>  	return;
>  
>  out_clear:
> -	write_sigio_pid = -1;
> +	write_sigio_td = NULL;
>  	write_sigio_fds[0] = -1;
>  	write_sigio_fds[1] = -1;
>  	sigio_private[0] = -1;
> @@ -394,12 +389,11 @@ void maybe_sigio_broken(int fd)
>  
>  static void sigio_cleanup(void)
>  {
> -	if (write_sigio_pid == -1)
> +	if (!write_sigio_td)
>  		return;
>  
> -	os_kill_process(write_sigio_pid, 1);
> -	free_stack(write_sigio_stack, 0);
> -	write_sigio_pid = -1;
> +	os_kill_helper_thread(write_sigio_td);
> +	write_sigio_td = NULL;
>  }
>  
>  __uml_exitcall(sigio_cleanup);


