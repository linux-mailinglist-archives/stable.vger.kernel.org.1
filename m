Return-Path: <stable+bounces-159095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DFCAEEBF2
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 03:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEF837A6022
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 01:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6941E515;
	Tue,  1 Jul 2025 01:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkrA9BpE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4FE2770B
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 01:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332525; cv=none; b=HjdDtGmoPVDdeXUlj803zBRdhgsBM53gBNhqCydGIkHocnahM4B60BzxDBsPrvKvl0CKpqg0n4HQ2Us8bA8rAkS6HSSgopX485OHvfLwEXLvG7sm1pUeOPWkdJVvAO1GyulpHnUYU//sGOwBw6zLkLLFrd30H6MnT1IQ6x39lfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332525; c=relaxed/simple;
	bh=lGqQJwtZf76JX4l6XiX1rtm2inNWhzhrr5dV0yFy7SY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiaYGUGYHSlzQal/FV5kY9DweuuT930/6oR5YcQ//va8xcwY9EjL8qaUbU0/2iGXrV3RV94FqfPHMEncb2fSXB1h+r1AMxgxgyqOXBrW4CUbtwexSlDH+ePBhiDsLJv52jxT0I5sxL22R6vuYsOcimgvXt4CaaR3KRCu4faGCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkrA9BpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90EFC4CEE3;
	Tue,  1 Jul 2025 01:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751332525;
	bh=lGqQJwtZf76JX4l6XiX1rtm2inNWhzhrr5dV0yFy7SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dkrA9BpEMDVlgnNcRGwzfS5I28tToE5CjlKWnJjsLAWxQ7yH97mX9/ToNdTgMtsv/
	 t/82XphTDIWnZodbrB2iITC+9/WNaaZhj/QxLaRMuy6SD2cU3ea7Vv1g7ZHLApv72y
	 NzvBeVPVjVoZ0zk7CSHWuOhIL1qpDYESjxc9BlX+y1CuuvEezFyu/MDB8BG0gAkTci
	 hfev+nwCcZhM76Y+wRkKP0Mq6dpZuAomNhtwW47sAG54v1vXB8vQ19GDyP2J1/GjJG
	 DqNAc9fFpdxNuWylX9BOM2MhLMZ5vkQ66fPxcQ/uMR+nIil6SlO3LPuGxzmNzrJMJd
	 DUeLtTuflvvfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brendan Jackman <jackmanb@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable] ipmi:msghandler: Fix potential memory corruption in ipmi_create_user()
Date: Mon, 30 Jun 2025 21:15:23 -0400
Message-Id: <20250630142531-e1d4b066523883eb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250630-ipmi-fix-v1-1-2d496de3c856@google.com>
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

The upstream commit SHA1 provided is correct: fa332f5dc6fc662ad7d3200048772c96b861cf6b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Brendan Jackman<jackmanb@google.com>
Commit author: Dan Carpenter<dan.carpenter@linaro.org>

Note: The patch differs from the upstream commit:
---
1:  fa332f5dc6fc6 ! 1:  5984afb270d63 ipmi:msghandler: Fix potential memory corruption in ipmi_create_user()
    @@ Metadata
      ## Commit message ##
         ipmi:msghandler: Fix potential memory corruption in ipmi_create_user()
     
    +    commit fa332f5dc6fc662ad7d3200048772c96b861cf6b upstream
    +
         The "intf" list iterator is an invalid pointer if the correct
         "intf->intf_num" is not found.  Calling atomic_dec(&intf->nr_users) on
         and invalid pointer will lead to memory corruption.
    @@ Commit message
         Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
         Message-ID: <aBjMZ8RYrOt6NOgi@stanley.mountain>
         Signed-off-by: Corey Minyard <corey@minyard.net>
    +    Signed-off-by: Brendan Jackman <jackmanb@google.com>
     
      ## drivers/char/ipmi/ipmi_msghandler.c ##
     @@ drivers/char/ipmi/ipmi_msghandler.c: int ipmi_create_user(unsigned int          if_num,
    @@ drivers/char/ipmi/ipmi_msghandler.c: int ipmi_create_user(unsigned int
     +	goto out_unlock;
      
       found:
    - 	if (intf->in_shutdown) {
    - 		rv = -ENODEV;
    --		goto out_kfree;
    -+		goto out_unlock;
    - 	}
    - 
      	if (atomic_add_return(1, &intf->nr_users) > max_users) {
     @@ drivers/char/ipmi/ipmi_msghandler.c: int ipmi_create_user(unsigned int          if_num,
    - 	} else {
    - 		*user = new_user;
    - 	}
    + 
    + out_kfree:
    + 	atomic_dec(&intf->nr_users);
     +out_unlock:
    - 	mutex_unlock(&ipmi_interfaces_mutex);
    + 	srcu_read_unlock(&ipmi_interfaces_srcu, index);
    + 	vfree(new_user);
      	return rv;
    - }
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.15.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

