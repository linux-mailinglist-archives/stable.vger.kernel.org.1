Return-Path: <stable+bounces-136637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978C2A9BB32
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 01:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C153B1970
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 23:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB412211472;
	Thu, 24 Apr 2025 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4OmMfz5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72870A93D
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745536985; cv=none; b=agqPLbsE389hKq7adKr5tJ8j7oUHhowOjU60QaFr1kpLP1W4Gtl3VnrYIQ9czPuj1Ruw9mGkfYHIjkpM2yQMb8R+rApAxbs8iBtdCKQMuDRIG0oPQeyzBoVO9PHWX/iZuythWWBMDFHxL78A+NNSqPqKpYnQCqhzj0bT4eoKJtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745536985; c=relaxed/simple;
	bh=y/vA11JFb1qH/EpzmwlTMOBRSH/VeYRoaghAQKWLEso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szu81cA7GYdnMW47BrANa5ZO5sSYNxrDiZeNwonHE7gicQ+NVfhY6BORjPyq2WWgYelhMgRR6J7hajPF72c9JedcvpEeF51z1gc07Roq2B/92m6Qfsn12T0iSW0zR0IOrZtfWcQ3eKn9cAwR9vkBJjvOq13kkzeoc+KAfp/ZeDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4OmMfz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E5AC4CEE3;
	Thu, 24 Apr 2025 23:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745536984;
	bh=y/vA11JFb1qH/EpzmwlTMOBRSH/VeYRoaghAQKWLEso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4OmMfz5QtgfaqQYiUaNjL/ISZ4TKF0puly5jrwYOFvNBNh4BvQiDXph9Z1MMndSf
	 Yp0oZgyHs8NYwdO5x4OQqZFpb9fPmkVwFwMbytT1lv3NlraCOuiUupeTrD34mJlFuP
	 gsCtbRqSV4CofMwxjTBA3ENUBPN4RBfQ4mievu0GuPq9A1fk2d6jBcFaV0Riy04p+H
	 tM/SHdg2xQo2xYduROeaiLr0i7GS63NlLoEPlXcZC34TCKcEGFPMNCZaqE48qjs9sy
	 Ef4YWufG182s+H05phmDFLONjQQllf4zZ8EuKzGGR/CpTWCftzUA587Mb5oOCnst1X
	 maN5OD8AqsoHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bigeasy@linutronix.de
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable v5.4] xdp: Reset bpf_redirect_info before running a xdp's BPF prog.
Date: Thu, 24 Apr 2025 19:23:00 -0400
Message-Id: <20250424171251-9b38344c09132f82@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250424130528._4Gap8TB@linutronix.de>
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
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

