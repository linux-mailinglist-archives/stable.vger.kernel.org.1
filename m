Return-Path: <stable+bounces-203008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E17DCCC87C
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 16:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 856CD3011758
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 15:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E07357A42;
	Thu, 18 Dec 2025 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1XxwnC5"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72F1357732
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072491; cv=none; b=g+GeTU8axQe1UW5xolzHjsCjZyf59Gen4AcsEqt7eAoG5Yxhvi7j887dAL2ptLmBYA7uVPDqzP8vdKIAN9lDAnHFJfrHVblk9ehqF/+i6KQ3u1AKRu8NTB3nPMXt/os+HxdKH+exGDBCOb+zfcqvXkFlEfqRmSn5wet1aJ4y9Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072491; c=relaxed/simple;
	bh=D9pCvmgHfKHhclySGALmaArbCG87hbEFQbQgSN0/Iec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shdw+6A4TqFcj996nqPjxc9fhZx2tiCKTS4/fub6lIg32igR4L75w/WWKOh/aVu8yi9n0TnSJnnTfPGtYn+RLYvChR9J8+VPe4ecbRCQwGQnahCs2eN0feN+1chHl0XrqsaP7ounmmFrsKxumkH5bmVZpQCH0aQGznCW7j+Ms1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1XxwnC5; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8bc53dae8c2so113329485a.2
        for <stable@vger.kernel.org>; Thu, 18 Dec 2025 07:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766072477; x=1766677277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTR2Xi7hPGXhBn6OmfrLXGQ7Lr6w/XZU5RKshp3nomQ=;
        b=C1XxwnC5BWAC+aslPF6XbiaKBpr81BUYBntsDfE9djHFzglEEsKHMZ+KA4xK8Tkkr5
         xKBWvaJCVCfa9cQ/2Y8EOk4nF4ioT3KXTxfjBDfbPzEWpHmADkQhM7SxMYMQFXEWLhRP
         bURysmjeKc+rOCm+qT55bke1fEVzblyvibZazeV2pG65ZhFioXIM0foBND79KxnJaK/7
         gMtjclrykhV2eHZKPYt4PyIKJJ+CEdcl1pqi1wHdmTmrVBn50OahZ2aB1+kAXyu+Ecis
         9cF4MIE7Hnq6s3mV+xbtMOLuGgkckhKMqzJMv2QSfPF73qPmyRDj7JkohFRblItMuCqy
         uD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766072477; x=1766677277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oTR2Xi7hPGXhBn6OmfrLXGQ7Lr6w/XZU5RKshp3nomQ=;
        b=TFDSfIp4og+J6yW1rnanVnhpLy1r8NQ9uK5/f/G69JC3oBfbqLdeN0xVUM+f2spqVd
         1d/e414rgEy1xEWLBSo7IignX1P3BB9OMnkd6yRMZcXVvsmT3r+4iBEOTXAVUHO6fep1
         tHu0c1C5fCGJvbtC1oJ4Q86BHIz3ZeL7EKDp+IguhP70RhJz0o7bOHEJ5OBL7aSMrwFw
         suGpEJxdGw+b/0gTpsihXo1oQgSD0yqp29+xw5osBoA/OtOtAR7kjNlNRRST9M7vEvwn
         O2uVyzjhjq69z+bqiXzeQ0DEwOW8IhOEQOd0ucuoMqASSMJ3IdBdLIrCi7Oejj3QVu1n
         pVxA==
X-Forwarded-Encrypted: i=1; AJvYcCUVGaWO2ZUonqb7PEsF4ufWtcwLfvNz8BPPU1AkQ/jpb3E6gkXaifvRy+qcpCJwFK+oYKCSkgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykfI+RCrpbSmqYlsRbtLbnQJThoGUOzG81fEbxzmnuzVMAVRiG
	GfcceRFJ8Eg7y7jJZW0PedF8QLx+T+Y65ZYhwdKnIJ2n+GjFyJ2PtVQarbeg1yuuMQE=
X-Gm-Gg: AY/fxX5Dqv8eo6s4j+b6l89fCrCa4wQOoqlwlx63VXKaCW2eiFgcAl0BMZlO0q4kN7c
	dhXOewudpEu2RNWAcnZuQh+0w0pBGUHGxcsLi/+BJinz/zfbfGQgG5tiupjm7E4sT195tH7SVWf
	JiI+ongyCGqunobw143SGnpIeKTFa79NEFj5nKDgixB+zLXbIGi0B11pQoO0CgjN2hc01NUwqvj
	z6OlaluuK5raERX9loVphMaZu4s68G4Q5+OhsI4hrEvuZd+My9UCcnv8NAX5Fto+vaVyVNROd7m
	3a5xPps+83NDYeXlmbL/GgFUNlvLWgmbd6/eSe3K34zyb6kYQKG1eEZL10BhMIEB+wVI+fCeUh/
	4JmHxnzRG8f3kLL0aHZutMyyx5biLSyiXPMf7EmcL1RGwEnjcLDALY73f/+k5EnuROsKcWDUyl7
	z/Exlf1zMhPHWZKI/+ro53hIs1XEdRsqU3RcYzYuQoB8U7NHwEFpbubFpqb3QcX6LtzCBNyzGcP
	1zpbfaS2blaUF4=
X-Google-Smtp-Source: AGHT+IG3NHC+GiOj6SEx40esXYclg7WwHlsCmdk51qsC0RX+EU1EmgZcNjmuvg0NYvO5MmU0Sbrn2g==
X-Received: by 2002:a05:622a:411b:b0:4eb:a33d:1f45 with SMTP id d75a77b69052e-4f1d04db77dmr300106571cf.33.1766064991103;
        Thu, 18 Dec 2025 05:36:31 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f35fdba268sm14738231cf.32.2025.12.18.05.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 05:36:30 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 41BA5F4007F;
	Thu, 18 Dec 2025 08:36:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 18 Dec 2025 08:36:30 -0500
X-ME-Sender: <xms:XgNEaZZ_VI-pW0sWBoXMe01o0WhmhhblYBW9uR5pT909zGtbq4QNSw>
    <xme:XgNEaf06Sr8rFl3TOP3sPe4Oz9hRsVmbS9-0s0BrzT_VouW8mIuO6w8zXmB-k6OL_
    NTr4v58VJtLvMB_pmhFdX1yRr-ssSmkdh_RPhTJXLjUZLzEDYYQkQ>
X-ME-Received: <xmr:XgNEadBwAX9gmpRw9JWLIHN_BoFYsXqmEq0iEx6Ue8DJroaF4aGI4wMvIco7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegheehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepffeggfehledtgfehieetueehkeeifffgudekudetteeuueefheevuefgfefgfeff
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdprghspghpthhrrdhgrhhouhhpnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghkphhmsehl
    ihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorh
    hnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhsshhinhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:XgNEab9bYvIJ9eGirSYofe4ZzxNOp3DtfQHf5DDR9cYoKkBqB1Jo-g>
    <xmx:XgNEaYUaRilsZDXXwOvRdU6F4kdGx_oiZ0bsWxNV6l6PBD1mQw1_8g>
    <xmx:XgNEaUKY2q3Rq5PUWxiaq-8B6gvlFWk69C8DOeljIgXJxLJ-ZNGwTQ>
    <xmx:XgNEacAqYR6Cj2SfGiw3PQQzIdWIjT8VrCQs77D8Asw1O1bqArRWmQ>
    <xmx:XgNEaUETe9j077wIAkVLMVauGkNv-hTNrJsoMiMh39vTv-_YrT37Xmnh>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 08:36:29 -0500 (EST)
Date: Thu, 18 Dec 2025 22:36:27 +0900
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] rust: task: restrict Task::group_leader() to current
Message-ID: <aUQDW-oFv9f7gVQ1@tardis-2.local>
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

On Thu, Dec 18, 2025 at 09:41:00AM +0000, Alice Ryhl wrote:
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
> 
> Reported-by: Oleg Nesterov <oleg@redhat.com>
> Closes: https://lore.kernel.org/all/aTLnV-5jlgfk1aRK@redhat.com/
> Fixes: 313c4281bc9d ("rust: add basic `Task`")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> The rust/kernel/task.rs file has had changes land through a few
> different trees:
> 
> * Originally task.rs landed through Christian's tree together with
>   file.rs and pid_namespace.rs
> * The change to add CurrentTask landed through Andrew Morton's tree
>   together with mm.rs
> * There was a patch to mark some methods #[inline] that landed through
>   tip via Boqun.
> 

I think I took that change through tip because it has the changes to
`current()` and `raw_current()` which belong to the scheduler part of
task.

> I don't think there's a clear owner for this file, so to break ambiguity
> I'm doing to declare that this patch is intended for Andrew Morton's
> tree. Please let me know if you think a different tree is appropriate.

Make sense to me.

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

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

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

