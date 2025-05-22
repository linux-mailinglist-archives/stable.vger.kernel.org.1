Return-Path: <stable+bounces-145976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96C3AC021C
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3AC11B64658
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37E37405A;
	Thu, 22 May 2025 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fexyxqP4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A0B3FBA7
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879526; cv=none; b=NMFQIyNVSDqhAoKu47fGn4d3w1QJv9Xdyuw+taQ5jIHf4pt1p9oFn7QBqYeadRV9DSxzX3oJvSRFvoa5jdnfIGZLar0fOcJGPy0tn7HSEK/Tkfa11jDL+DZO0gVY0JG1qxJBYmPXjilsCc8DROuUZwlnCDrVK7wCeLiaXOxWOM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879526; c=relaxed/simple;
	bh=oNLCwE/7ESxUOXRN6+UX0tTb0B4KFdMZqBcddDhivJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hn/h2refuwJgNLjh6NxzbrAAd/LcERVpAldR7XtUP2fqSWOj8H349cabHQoMae4XtshCcPJMH3gvJRTAmMlsNnYEb9ZYpOn0amHdUYqTix63ZTaUSN9Nhk9n2xX4vG/yy024jhPQd+A3YsOk5go/Zj7AJ59jf2gsRP0dI3Xwa6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fexyxqP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC25C4CEE4;
	Thu, 22 May 2025 02:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879526;
	bh=oNLCwE/7ESxUOXRN6+UX0tTb0B4KFdMZqBcddDhivJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fexyxqP4316iFxBD/6nyUPjc//H+iR1ykCInCmIApq7Bt/cR//Lh7wlMF8Etq/jQH
	 8HEgnhOs54wINlqVL8LNpn9ZxG8mscewd9qB81CE3AJWzFYJMeKMwfBvX1DfeRKj0x
	 FUJI6hMtYIJ0G/ikvGMVmJfS8tWP8wnXxcAGB0etJFKN3L8353fort88OuXsfe+qjl
	 xBuwNi/GGxXJxs7bEOfmhw23vo/lnddgG0pXAEkvHMhYRQw5IrnMtVyLaPNtHCCgpk
	 ev/SBevntaSF7N1udjJq72BWN3Ivl1yyh+I5wFQZbebFWtHL/0eOb/BGxjgppIWk2p
	 bICBMSrh2X5wQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 23/27] af_unix: Try not to hold unix_gc_lock during accept().
Date: Wed, 21 May 2025 22:05:22 -0400
Message-Id: <20250521212941-ee16b19cb1a68a68@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-24-lee@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
ℹ️ This is part 23/27 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: fd86344823b521149bb31d91eba900ba3525efa6

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Found fixes commits:
1af2dface5d2 af_unix: Don't access successor in unix_del_edges() during GC.

Note: The patch differs from the upstream commit:
---
1:  fd86344823b52 ! 1:  24f48aefd8acb af_unix: Try not to hold unix_gc_lock during accept().
    @@ Metadata
      ## Commit message ##
         af_unix: Try not to hold unix_gc_lock during accept().
     
    +    [ Upstream commit fd86344823b521149bb31d91eba900ba3525efa6 ]
    +
         Commit dcf70df2048d ("af_unix: Fix up unix_edge.successor for embryo
         socket.") added spin_lock(&unix_gc_lock) in accept() path, and it
         caused regression in a stress test as reported by kernel test robot.
    @@ Commit message
         Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
         Link: https://lore.kernel.org/r/20240413021928.20946-1-kuniyu@amazon.com
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    (cherry picked from commit fd86344823b521149bb31d91eba900ba3525efa6)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: struct unix_skb_parms {
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

