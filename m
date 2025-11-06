Return-Path: <stable+bounces-192581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CDEC396B4
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 08:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0893AFCAE
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 07:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36C7298CAF;
	Thu,  6 Nov 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="NorLj0cE"
X-Original-To: stable@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9748E221DAD
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 07:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414716; cv=none; b=O1cHEudyP80hieAr4twKizQ9ebIse5GbkgTdWwuu8BeY7GeLOPoeZ1O2w/BsVxPG9LDtLKlME2MpuZ0+6H6FfwgKSMhBLusYfd1FsKUtHvLq8NyL679Aunwvfxo4mCQomNX598L8qOcqV+9eIlKVpINM1Ffw8du3KFht1M4BL4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414716; c=relaxed/simple;
	bh=BJlr+nPTAYN5YsdsgVxazWRhHsecg7JTFTjgWQCBS8I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HwcBIDxuoXP1qzMO6EOZhyxyKuCN8Hsj5XMQv4eXR4jXy6jx7FFgz2puSFHSxak2Q1d3LFFKlH5f0sJdgsioXzAOa8DxA5QjBvIyfgh/bUoGRoE3sPtStmb73uaZ66epdst/u0gCSZZwlnZSMtN9AuZpugSPu6+XS8f8Jjqxwko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=NorLj0cE; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
DKIM-Signature: a=rsa-sha256; b=NorLj0cEPbsh9Tj9vOkBdKYqn2SNGcsw9YrUGP5oFQ0yJbtHfQkT9x5mB9AZCn1QYg1/ZHh5MZ5QTC5rbp0O76YA6XY9IaBjG+2hDZvC+1CbKifz1bCSkkUl58IX5F1EMaEpmw06EN1j+TwC1hm6n/VOATWOaDs6ft2wKJN2dxGylcfNhS3iNsJOdaWywzWzjb4VBFwO7oNS4OR3kI3DQOkAt8zdS85NMiLMjPkDpSDeEQehecNCeVDGfG7L/t46rv3FpKbqoxnlWOSF+aRwhEd5RqkzbKHZqDOwO0o9nvgxz6mYqTK+pZuOe+pY3L34EGqjSrxr6Dw1CbzE64S+tA==; s=purelymail2; d=purelymail.com; v=1; bh=BJlr+nPTAYN5YsdsgVxazWRhHsecg7JTFTjgWQCBS8I=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: stable@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1624439273;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 06 Nov 2025 07:38:29 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
	(envelope-from <peter@korsgaard.com>)
	id 1vGuZg-006JF5-11;
	Thu, 06 Nov 2025 08:38:28 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ivan Vera <ivanverasantos@gmail.com>,  git@amd.com,
  stable@vger.kernel.org,  Michal Simek <michal.simek@amd.com>,  Srinivas
 Kandagatla <srini@kernel.org>,  Ivan Vera <ivan.vera@enclustra.com>
Subject: Re: [PATCH v6.6-LTS] nvmem: zynqmp_nvmem: unbreak driver after cleanup
References: <20251105123619.18801-1-ivan.vera@enclustra.com>
	<2025110655-imprecise-baton-f507@gregkh>
Date: Thu, 06 Nov 2025 08:38:28 +0100
In-Reply-To: <2025110655-imprecise-baton-f507@gregkh> (Greg KH's message of
	"Thu, 6 Nov 2025 16:23:16 +0900")
Message-ID: <87frar7gqz.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

>>>>> "Greg" == Greg KH <gregkh@linuxfoundation.org> writes:

 > On Wed, Nov 05, 2025 at 01:36:19PM +0100, Ivan Vera wrote:
 >> From: Peter Korsgaard <peter@korsgaard.com>
 >> 
 >> Commit 29be47fcd6a0 ("nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup")
 >> changed the driver to expect the device pointer to be passed as the
 >> "context", but in nvmem the context parameter comes from nvmem_config.priv
 >> which is never set - Leading to null pointer exceptions when the device is
 >> accessed.
 >> 
 >> Fixes: 29be47fcd6a0 ("nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup")
 >> Cc: stable@vger.kernel.org
 >> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
 >> Reviewed-by: Michal Simek <michal.simek@amd.com>
 >> Tested-by: Michal Simek <michal.simek@amd.com>
 >> Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
 >> State: upstream (c708bbd57d158d9f20c2fcea5bcb6e0afac77bef)
 >> (cherry picked from commit 94c91acb3721403501bafcdd041bcd422c5b23c4)

 > Neither of these git ids are valid, where did you get them from?

git describe --contains c708bbd57d158d9f20c2fcea5bcb6e0afac77bef
next-20250505~21^2~1^2

I guess it should have been fe8abdd175d7b547ae1a612757e7902bcd62e9cf
instead, E.G. what ended up in master?

-- 
Bye, Peter Korsgaard

