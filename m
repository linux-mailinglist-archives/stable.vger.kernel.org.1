Return-Path: <stable+bounces-202963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8652CCB675
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 11:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8ABB130797D5
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F460215055;
	Thu, 18 Dec 2025 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXIQuuWE"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4368F26F2B8
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766053941; cv=none; b=jSPhqUIcUtaLssz7qan1zyZOOFMyQXlgR5mmBWPhghbvViAeWNmAUYjZLCS+LLrJVKv/8O7C/ge0slMOVy2yWgGIsnDoxI7iTVBvNg+Qj5Xq9fY5XOVI+jsYaKrcowOV7yK46loNpfpIgdzRFq9fFDsc2LQPIISUsNKNs2tF0hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766053941; c=relaxed/simple;
	bh=WEw+8wSpWC19+iqEuW0++sr+v2+f+3QOV5qZtNFnOWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFY1HFdR0nIUTR7p5hZokxJzTGxgxWK+4GOktWXTUTzhVNQG5qdJlw6KW7LDxoZAc07El5VyrV9bsj+vgq5/Q1ggnohdNDbQpA/biPXqiRSZAGxabv/bZFdCP5MK49J2+iQ0lAusrbZW2Asobb3f5Jk877UOseB05b06cI1MqDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YXIQuuWE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766053938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/I5sayEMN0mY3tDaMbjqVMPYXNApewEJkrlF9jhCSY=;
	b=YXIQuuWEQbgrS/KMF37+Su282DsLrNP57XUKMfAFF1crVHQ9Wz/e1KUVyTlT5wL0Svlp4T
	nqYSFW4T+DSeOww6DrQxz7oeSnf1F8oZl6SeuASioQdlIjQ1HSfo2gKyx2MwWfsn73qNQr
	q98pT1Ggo91M2TY4DNho+fs+Z2BpEcc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-jFEx2aaJO8u4KW9vHTwOWg-1; Thu,
 18 Dec 2025 05:32:12 -0500
X-MC-Unique: jFEx2aaJO8u4KW9vHTwOWg-1
X-Mimecast-MFC-AGG-ID: jFEx2aaJO8u4KW9vHTwOWg_1766053931
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 85DEA195DE49;
	Thu, 18 Dec 2025 10:32:10 +0000 (UTC)
Received: from fedora (unknown [10.45.226.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A8C7A180045B;
	Thu, 18 Dec 2025 10:32:04 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 18 Dec 2025 11:32:09 +0100 (CET)
Date: Thu, 18 Dec 2025 11:32:02 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Alice Ryhl <aliceryhl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] rust: task: restrict Task::group_leader() to current
Message-ID: <aUPYIm6jhceRC4J7@redhat.com>
References: <20251218-task-group-leader-v1-1-4fb7ecd4c830@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-task-group-leader-v1-1-4fb7ecd4c830@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 12/18, Alice Ryhl wrote:
>
> The Task::group_leader() method currently allows you to access the
> group_leader() of any task, for example one you hold a refcount to. But
> this is not safe in general since the group leader could change when a
> task exits. See for example commit a15f37a40145c ("kernel/sys.c: fix the
> racy usage of task_lock(tsk->group_leader) in sys_prlimit64() paths").
>
> All existing users of Task::group_leader() call this method on current,
> which is guaranteed running, so there's not an actual issue in Rust code
> today. But to prevent code in the future from making this mistake,
> restrict Task::group_leader() so that it can only be called on current.
>
> There are some other cases where accessing task->group_leader is okay.
> For example it can be safe if you hold tasklist_lock or rcu_read_lock().
> However, only supporting current->group_leader is sufficient for all
> in-tree Rust users of group_leader right now. Safe Rust functionality
> for accessing it under rcu or while holding tasklist_lock may be added
> in the future if required by any future Rust module.

I obviously can't ACK this patch ;) but just in case, it looks good to me.

Although I am not sure this is a stable material... Exactly because,
as you mentioned, all existing users call this method on current.

> I don't think there's a clear owner for this file, so to break ambiguity
> I'm doing to declare that this patch is intended for Andrew Morton's
> tree. Please let me know if you think a different tree is appropriate.

If Andrew agrees and nobody objects this would be nice. I am going to
send some tree-wide changes related to task_struct.group_leader usage,
it would be simpler to route them all via -mm tree.

So far I sent the trivial preparations

	[PATCH 0/7] don't abuse task_struct.group_leader
	https://lore.kernel.org/all/aTV1pbftBkH8n4kh@redhat.com/

and I am still waiting for more reviews. Alice, perhaps you can review
the (hopefully trivial) 1-2 which touch android/binder?

Oleg.

> ---
>  rust/kernel/task.rs | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 49fad6de06740a9b9ad80b2f4b430cc28cd134fa..9440692a3a6d0d3f908d61d51dcd377a272f6957 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -204,18 +204,6 @@ pub fn as_ptr(&self) -> *mut bindings::task_struct {
>          self.0.get()
>      }
>
> -    /// Returns the group leader of the given task.
> -    pub fn group_leader(&self) -> &Task {
> -        // SAFETY: The group leader of a task never changes after initialization, so reading this
> -        // field is not a data race.
> -        let ptr = unsafe { *ptr::addr_of!((*self.as_ptr()).group_leader) };
> -
> -        // SAFETY: The lifetime of the returned task reference is tied to the lifetime of `self`,
> -        // and given that a task has a reference to its group leader, we know it must be valid for
> -        // the lifetime of the returned task reference.
> -        unsafe { &*ptr.cast() }
> -    }
> -
>      /// Returns the PID of the given task.
>      pub fn pid(&self) -> Pid {
>          // SAFETY: The pid of a task never changes after initialization, so reading this field is
> @@ -345,6 +333,18 @@ pub fn active_pid_ns(&self) -> Option<&PidNamespace> {
>          // `release_task()` call.
>          Some(unsafe { PidNamespace::from_ptr(active_ns) })
>      }
> +
> +    /// Returns the group leader of the current task.
> +    pub fn group_leader(&self) -> &Task {
> +        // SAFETY: The group leader of a task never changes while the task is running, and `self`
> +        // is the current task, which is guaranteed running.
> +        let ptr = unsafe { (*self.as_ptr()).group_leader };
> +
> +        // SAFETY: `current.group_leader` stays valid for at least the duration in which `current`
> +        // is running, and the signature of this function ensures that the returned `&Task` can
> +        // only be used while `current` is still valid, thus still running.
> +        unsafe { &*ptr.cast() }
> +    }
>  }
>
>  // SAFETY: The type invariants guarantee that `Task` is always refcounted.
>
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251218-task-group-leader-a71931ced643
>
> Best regards,
> --
> Alice Ryhl <aliceryhl@google.com>
>


