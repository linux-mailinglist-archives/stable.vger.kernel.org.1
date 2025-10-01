Return-Path: <stable+bounces-182962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFCBBB0FF4
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 17:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D2E174471
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 15:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFE21804A;
	Wed,  1 Oct 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrTXiVx2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7A3259CBD
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331459; cv=none; b=hGs6xtSKT9lDkmlA443gYZHaAXIH4WNlxcn/CAI8v7j8Qsi9Q/0rC/gbbmrANh8DcS2NJEaid2PbTb2Uip++RmxWNCXGtzQAkfFMF7sI0UG1ZI4QJLmEzTNaBe/EVqtjPVyobyoD3vlQdE+asx1L5oXb84UjnRcB+Q/08E9XuWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331459; c=relaxed/simple;
	bh=w7eYRsLwIC7pDBqChpp+XZupNqoZ5FmulUOCUwmcNUA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SbCSfGjQdwW/y8ssmmqmFBno1aV7dq2i7FkAZKqqHHDMyHp8NdN+I9XmbupE07WwS1GovrKIohL5YLAYQ+1g3mW51XhbCsrBmo6a7h8hKz+d2eyRFmPbUPLDsCh/2f4Wj4nykWH7sczQ4Z39Mafyw6sBMQiyw1Eq8Vss0hEFGX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrTXiVx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2030C4CEF1
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 15:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759331458;
	bh=w7eYRsLwIC7pDBqChpp+XZupNqoZ5FmulUOCUwmcNUA=;
	h=Date:From:To:Subject:From;
	b=DrTXiVx2z1qFyFWrXewoenr0+fEseK3PWBGJ5LLHCQnxlO4jnDZSEHRJdX+vgujkN
	 +3EPwxj9kO8tASPRg18ct8lOHQYkpUezZkeII0SyH2X8W4jMxj1/HQXJxsdkI9Z4c3
	 2AqIwF5lEalRhkWRBhKnNAAgo5DtFKp7fW/AzXROAgO0ldvjAFHgFF6XaweEr70jLc
	 jVFUuSFBeI763q0BE3jBGNlYCu4zCNWg0RqpfgGgfJa+RAkxyIOgLubP/spZAKvPO/
	 Nr2EXKM5ICPfprjSqtBnnA0GM02gB5zgVQ8yFO03e++JR0zRNGnVyyqXLhzHRRaf4q
	 gjPk3uPREjZaA==
Date: Wed, 1 Oct 2025 08:10:58 -0700
From: Kees Cook <kees@kernel.org>
To: stable@vger.kernel.org
Subject: Please backport commit a40282dd3c48 ("gcc-plugins: Remove
 TODO_verify_il for GCC >= 16")
Message-ID: <202510010810.7948CD9@keescook>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Please backport:

  commit a40282dd3c48 ("gcc-plugins: Remove TODO_verify_il for GCC >= 16")

to all stable kernel versions. This prepares the GCC plugins for the
coming GCC 16 release.

Thanks!

-Kees

-- 
Kees Cook

