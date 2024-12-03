Return-Path: <stable+bounces-98149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100DF9E2A7D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB56116257B
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D441FA840;
	Tue,  3 Dec 2024 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEZcEykn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97E41F8901
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249598; cv=none; b=VqKbxtJ0IyBUBsPeEQK9UEqeOKJEQqgCHl9zTiigAXvk8wztV/1olv0JvyAO6E3mEnnMxdTRh0hfDqt5k8fBpDGdhuQ61JRr95gF32KgItUy+Z44iUYlPN5LpEnM5jCtXZVQBftyLDAWSps1jhOi2BPGKMxLPpyqHgykK639OOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249598; c=relaxed/simple;
	bh=dh5bYB+6/8wXlVMlBqfwdU8bJ/nsBjY49weGLWjTe48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mps0cspBS8tli/tp3Ad+NRcAiaPmQ6px9YGWxbflyUeoyr2gF3J8JfRxrfyLLhXrLFnzoZd9v9ghoC/rzfU46xXDKmrAJ2/P1MXDS3EaTJXQJCwvgB4I94YzjBcAmq5ZUjJ4nJ6LdarmEPY2RDKIMq7Lp9PflSehtLyAoR0IqsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEZcEykn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E599FC4CECF;
	Tue,  3 Dec 2024 18:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249598;
	bh=dh5bYB+6/8wXlVMlBqfwdU8bJ/nsBjY49weGLWjTe48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEZcEyknAl1ARUnlk9EP5QYINeeXZ1QiBS+QRREXedOJaudmJhLcPaqFLa/W3O18z
	 B3gaOXqH+P7XnYpEu6BnMe+Py/h50Zdh/sfwA6PZbUBN+8MakinzHyPhBD1htFpQdU
	 ejXOhJrWqKp3RDShuiG23Q4wHQ9RebijsqpGqkNvNOYq3vE2YRI0QBb5QPfew44QUM
	 BX3wkNjUiKDK7oAaCkNoLaaq0VKp7psfsEoCBh8JxliR3u4rptuL1KXrC4IKw/X3LI
	 wcvzY3B3fovgJ0oFkZGFID+WqXGE8IZ80bIA/yhekNQ8p5kmgvJum5U7dEDJKBkw/v
	 +QUysvyP+Js1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 v4 3/3] net: fec: make PPS channel configurable
Date: Tue,  3 Dec 2024 13:13:16 -0500
Message-ID: <20241203130844-7464eab92e656a29@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241203141600.3600561-4-csokas.bence@prolan.hu>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 566c2d83887f0570056833102adc5b88e681b0c7

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

