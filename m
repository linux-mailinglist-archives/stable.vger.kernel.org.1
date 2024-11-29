Return-Path: <stable+bounces-95823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7699DE9C4
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 16:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227941647BE
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1BC1537AA;
	Fri, 29 Nov 2024 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcKx9onu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16730145A17;
	Fri, 29 Nov 2024 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732894629; cv=none; b=XSOkd75uJ3t/fkvyxYckZqq0hVrbskZvhuLEVjPukhNLOFx5soQKgWdyDR/GrNNCZnAQ5MqS18qkmsg20josqacDsi83DOJqrvKNwDXpp0u5kk0y+OJk5rwPELo7UUqPxe6vJd73JpVR8hIIHUD1kd0J+javD1XTklEwA+Cd44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732894629; c=relaxed/simple;
	bh=iZjwFTEk+pFpApbK1/Pl81mH5NE6tyJhyWcbEVWo/Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlY7R5rBH+lDr0dvi3pEr0eIvYMktYWZ/RuUJnrpucOeqe7oxfBY0/sEoitTxRE/1RBt5LmgKgxlj8t3+hgZszH7m/0VlfEoulksOYyVjncD8t5YxSbEj5lOF3A7aeUWKJQeH+mfLcCaJKIAwYMS5Jt18Fu413PIUwpv6NqVuY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcKx9onu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0D8C4CECF;
	Fri, 29 Nov 2024 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732894628;
	bh=iZjwFTEk+pFpApbK1/Pl81mH5NE6tyJhyWcbEVWo/Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZcKx9onu0sISrxdGUJgJJkCsKD4imjP8AOqm0N1Vx/06QYFctaccO63OIHKWhiNLU
	 qttpgUTypnFuq+/SKo7BotduYh4taxcav7DZybFBSbiBUzXyovwrKx6tnhIhf18myr
	 kn6IUS5rF9qvw0aGzBPGKQyY54r7zVcLtVcSpXyqI+eG1uzfsabsLvn44UqmQGTu/O
	 SltkGg/Smj24X29lgWGFgjUIh6O7pra6X+w/tfY8WVJ8v1kYH7KCZ5XfDzIE8TbKa0
	 mMUi7Z2jPOrkLxOMDGAJVthQxr/TKBs9FTmEGRhIefedEcRoP0L/fS6LPbP27NJka4
	 r++JE6xYj60Dg==
Date: Fri, 29 Nov 2024 10:37:06 -0500
From: Sasha Levin <sashal@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Erwan Velu <erwanaliasr1@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, puwen@hygon.cn,
	seanjc@google.com, kim.phillips@amd.com, jmattson@google.com,
	babu.moger@amd.com, peterz@infradead.org,
	rick.p.edgecombe@intel.com, brgerst@gmail.com, ashok.raj@intel.com,
	mjguzik@gmail.com, jpoimboe@kernel.org, nik.borisov@suse.com,
	aik@amd.com, vegard.nossum@oracle.com,
	daniel.sneddon@linux.intel.com, acdunlap@google.com, pavel@denx.de
Subject: Re: [PATCH AUTOSEL 5.15 11/12] x86/barrier: Do not serialize MSR
 accesses on AMD
Message-ID: <Z0nfomc6TKd-17S9@sashalap>
References: <20240115232718.209642-1-sashal@kernel.org>
 <20240115232718.209642-11-sashal@kernel.org>
 <20241128115924.GAZ0hbHKsbtCixVqAe@fat_crate.local>
 <Z0iRzPpGvpeYzA4H@sashalap>
 <20241128164310.GCZ0idnhjpAV6wFWm6@fat_crate.local>
 <Z0kJHvesUl6xJkS7@sashalap>
 <CAL2Jzuxygf+kp0b9y5c+SY7xQEp7j24zNuKqaTAOUGHZrmWROw@mail.gmail.com>
 <20241129133310.GDZ0nClg7mDbFaqxft@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241129133310.GDZ0nClg7mDbFaqxft@fat_crate.local>

On Fri, Nov 29, 2024 at 02:33:10PM +0100, Borislav Petkov wrote:
>On Fri, Nov 29, 2024 at 10:30:11AM +0100, Erwan Velu wrote:
>> We all know how difficult it is to maintain kernels and support the hard
>> work you do on this.  It's also up to us, the users & industry, to give
>> feedback and testing around this type of story.  It could probably be
>> interesting to have a presentation around this at KernelRecipes ;)

Or LPC? I don't usually end up attending KR but Greg is always there :)

>Yes, absolutely.
>
>And you should reserve a whole slot of 1h after it for discussion. Because all
>the folks using stable kernels or doing backports will definitely have
>experience and thoughts to share... who knows, might improve the proces in the
>end.

If there are enough folks who are interested in a BoF session I'm happy
to help set it up for LPC.

-- 
Thanks,
Sasha

