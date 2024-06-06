Return-Path: <stable+bounces-48299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3848FE735
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 15:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE631B247B4
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 13:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77745195F19;
	Thu,  6 Jun 2024 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sK3hwm/V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3656E195993
	for <stable@vger.kernel.org>; Thu,  6 Jun 2024 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679409; cv=none; b=JzIIN4n9/0jm4EcbKPKQgfhcfF+ZTSSu6f7H0jLV+SEI6Ct/QaY6UR/QNWR3iwHIaiII+NNl2FnNYRSvHOpQuMDqZaa956e/LttaoQfrRgn2LlPgHc5j84EYfQLIwEzP9QdrNtppgK8GYzfzXo1NtjUks3U66ju5W91OTt9Hpjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679409; c=relaxed/simple;
	bh=L/QL55K/uqmeyQ8qEUE2S0k9LP8l2TtqV3DDUE3Diww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1K9yXx60a3CreYsCkE9dJjO/ieZLcD+h5YK9IUYIFKbaGrXDMYTlpgPwmkVulNkJJO8tEl0xVyRD3Y9usIL0nLhHIOvbyj1geXaLc5QzmvaMrz2Kg8a7BQbaM5JNvSx9k7j0Gak5iAadraGA1arGTRP4QWSslc3iHefW0a/d3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sK3hwm/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB78DC2BD10;
	Thu,  6 Jun 2024 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717679408;
	bh=L/QL55K/uqmeyQ8qEUE2S0k9LP8l2TtqV3DDUE3Diww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sK3hwm/VZ+8Ti5SU9i4xx2Tldk64hH+J1eqDGfRy6h+OFwHDrXebTs4q+6fHwO+KG
	 wYQhUS0qjDX0wejATCYZkNfeKzc4RVgV4TMFcUBcWMvE41JARLSd/zpunS/QqDSF+A
	 NS1pBuANRz09gNuHu9SpfFKvUQJ2Z2qb2oNYVmi4=
Date: Thu, 6 Jun 2024 15:10:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>
Subject: Re: backport request
Message-ID: <2024060602-reacquire-nineteen-57aa@gregkh>
References: <CAMj1kXE3OuzR3kcyn_3pr4M3=QaV4Dqj=X6StUnRk9gM-1MQaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE3OuzR3kcyn_3pr4M3=QaV4Dqj=X6StUnRk9gM-1MQaw@mail.gmail.com>

On Wed, May 29, 2024 at 10:50:04AM +0200, Ard Biesheuvel wrote:
> Please consider commit
> 
> 15aa8fb852f995dd
> x86/efistub: Omit physical KASLR when memory reservations exist
> 
> for backporting to v6.1 and later.

Now queued up,t hanks.

greg k-h

