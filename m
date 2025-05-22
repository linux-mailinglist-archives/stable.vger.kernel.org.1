Return-Path: <stable+bounces-146014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 758D7AC024A
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E6B3BCDCA
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBE47DA8C;
	Thu, 22 May 2025 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFTaNLCG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EA67405A
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879722; cv=none; b=bVKOe6rkK0aP1k6GthKbsdMkFeWf+KN9hJ8jlaJcIkAlfS8u0cUpMWuvpgO9HOutCXHpOm0NhnyJg7PH33+NEonidus/qxJeEhxfETAB9uU9/WthLh7B9p1HzhwqMg9wWn/3DBwkEVJgnn+GXb3KQ8lX2Dy4pFhl3+Pl1iXIy5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879722; c=relaxed/simple;
	bh=7V7x2W+0PjCXEow4a0yRrmTJzP9wvwxVt3xj9Y7D4KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0QsQKG7GUNOVrW22cNVg7HJfPm3x6jv7T8p+ldh4cRtOqF7OoHfBeFnZ6Bj/qP98VjCDlpO31SpiSOvHMlxQqV5tbL/oDZ9W/m+NE1GDlilYz89VCUoAoYSuM0KItoPLA8pECawRAergLJ7rNR0i74+8rmNuqEIzy0bZZvNRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFTaNLCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A926C4CEE4;
	Thu, 22 May 2025 02:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879721;
	bh=7V7x2W+0PjCXEow4a0yRrmTJzP9wvwxVt3xj9Y7D4KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MFTaNLCGx8xRNV+0rK7YFBIISufSQtupejkzrLfEmiZsxp3M91Znz/MSjJJv/CMr6
	 5iL9aWQfFXmTyVxmdM5uotyaTiPs9ZR30q/N86dn7r8dBE15oTsFLpm8o+bqV9/MOy
	 VkMEHCjjQ+YgJvpyK9sS7oCRRdrMoRzrqO9NvOPvCwgUT87TowQZr4lpZaZ4WAmDyU
	 A/qCifbOUDZkQyiDt/B4UF6ejjbSofe42/rInRWU9ikqCMnKe25LqjzK7tKzc7quMO
	 7ISRoQRS8iC/jBgCNUsQFLf1IxtgydMrOawLE1WI7OMu9hsaVJ17TukcrzlNCMx5rq
	 XOvTz8pwiXv7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 01/27] af_unix: Kconfig: make CONFIG_UNIX bool
Date: Wed, 21 May 2025 22:08:37 -0400
Message-Id: <20250521190501-cbeeed17abffd634@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-2-lee@kernel.org>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 97154bcf4d1b7cabefec8a72cff5fbb91d5afb7b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Alexander Mikhalitsyn<aleksandr.mikhalitsyn@canonical.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  97154bcf4d1b7 ! 1:  dc0456caaf050 af_unix: Kconfig: make CONFIG_UNIX bool
    @@ Metadata
      ## Commit message ##
         af_unix: Kconfig: make CONFIG_UNIX bool
     
    +    [ Upstream commit 97154bcf4d1b7cabefec8a72cff5fbb91d5afb7b ]
    +
         Let's make CONFIG_UNIX a bool instead of a tristate.
         We've decided to do that during discussion about SCM_PIDFD patchset [1].
     
    @@ Commit message
         Acked-by: Christian Brauner <brauner@kernel.org>
         Reviewed-by: Eric Dumazet <edumazet@google.com>
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    (cherry picked from commit 97154bcf4d1b7cabefec8a72cff5fbb91d5afb7b)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/Kconfig ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

