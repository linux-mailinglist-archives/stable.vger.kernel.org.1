Return-Path: <stable+bounces-28298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6977D87D9C8
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 11:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CD41F219B7
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 10:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B236CA40;
	Sat, 16 Mar 2024 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUlDWooO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD81094E
	for <stable@vger.kernel.org>; Sat, 16 Mar 2024 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710585113; cv=none; b=t31R8ERdg9rYmIOzP9j/2oAm+dCAPunCB3xmnwZ3Qf1dNtwCzIoLLJZQgojrKq/IKI9fNTgRUypEL4hPntv6iHIJqCrCJ4GQUH3ViQ6kK0EdBUphaDFUbrOevGuD4u6xcuzvr5HDQG4opajYwlzH8oTxChY+Pg0+ded2W/14G8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710585113; c=relaxed/simple;
	bh=KDUEENbryw67AzH9eSQyHcWMdWZg6AR67YExBfsCK5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bK5byLrG1M1K7JiMQqlQm5l5RYGJktye3xPBnxjiG6fUkRlVHTe4jbMje/sR/dSWAAJ05oAEczy6AoYG3nZGJD4SUVGDGr8iwOxA5poTZI8alGQrJ6hpHcoSCyVpIOTigjiXaj4G+kN63t/DWNSWn2SWF/XigkJ2ea80TrIJaUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUlDWooO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78033C433F1;
	Sat, 16 Mar 2024 10:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710585112;
	bh=KDUEENbryw67AzH9eSQyHcWMdWZg6AR67YExBfsCK5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jUlDWooOKAdoPSAgv4tK1aVNla/2f6ILx9OpSbKTf++RfllP6mPZuYqw5Zlp9itx3
	 hq20hgZJhqWRl54PmVb3Ou6K/KiWBpZFD3uEey0jt3S3JPXt3BBhTheUnpbX0jeXOD
	 HGYl/8+dESKQIx5E7YWfxp29N94MI70N80RLpwE5c+IsvZA7EswQeizBMmc5khsgwl
	 Ix0jxpEEwwaNk6Xwbhb/ObMilbQmA/g4/xWiY1AFTgxwl3/z1luwpxI8RUZh/ySK8/
	 XInxq22EJ8KtJGfjzsQNE3QlCb4qMdxP30rS37bQnUS9c56reCnGsc0Aha27uG6Ote
	 yphm7+OWzw1TQ==
Date: Sat, 16 Mar 2024 06:31:50 -0400
From: Sasha Levin <sashal@kernel.org>
To: Robert Kolchmeyer <rkolchmeyer@google.com>
Cc: stable@vger.kernel.org, Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v5.15 0/2] v5.15 backports for CVE-2023-52447
Message-ID: <ZfV1FgRutdqvamdY@sashalap>
References: <cover.1710187165.git.rkolchmeyer@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1710187165.git.rkolchmeyer@google.com>

On Mon, Mar 11, 2024 at 02:30:20PM -0700, Robert Kolchmeyer wrote:
>Hi all,
>
>This patch series includes backports for the changes that fix CVE-2023-52447.

I'll queue up this and the 5.10 backport, thanks!

-- 
Thanks,
Sasha

