Return-Path: <stable+bounces-114397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4A8A2D71F
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 17:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF1E3A62D2
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 16:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87782475E7;
	Sat,  8 Feb 2025 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finder.org header.i=@finder.org header.b="yFVjUOOF"
X-Original-To: stable@vger.kernel.org
Received: from greenhill.hpalace.com (greenhill.hpalace.com [192.155.80.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C572153BD7;
	Sat,  8 Feb 2025 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.155.80.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739030609; cv=none; b=t2ajDyu8D2KfXdt6DmwMcFEIGOSrA7Q390GF6eY7xsUHG2Fvmvp4ZUbiMte3ywyCI90C55kkiihCHqcw+EhWTMzEUd02xveCqSQTmI+nhN/ZoClF2KRZgqDe8lpZzluucFSehW9inZMGoTpcgHGISNmPZNcdW9A1eXTx+fwk/Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739030609; c=relaxed/simple;
	bh=1M4vSi9v4Q6+ZEn5fp30w21T7b4G93BvePKsismnTr4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FmqCOpjGoXrOY0Pmgk2LMlKPGDeQuQB65DphD1CvjpsFl24PTdn65HcDYYA/6MtCp5CP5zzZnsZUD+oaHYazj2mCvsr9ZggLGao12JY9mAw9YI9UvdwVWN5nU2lYsQMVdB+F8/PWGUX0Pvd/J88VFEeeJsT+WieupfAq1ST8cVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=finder.org; spf=pass smtp.mailfrom=finder.org; dkim=pass (2048-bit key) header.d=finder.org header.i=@finder.org header.b=yFVjUOOF; arc=none smtp.client-ip=192.155.80.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=finder.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finder.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=finder.org; s=2018;
	t=1739030607; bh=1M4vSi9v4Q6+ZEn5fp30w21T7b4G93BvePKsismnTr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yFVjUOOFkqPHK9+Tm7nQ7ZlvmT3oQr1aV5HlB+WEvJHQOK4aoLXGcbLx/CttoplMt
	 ygh6tIeTlhg+3zdMhzjdjvAy17sJMmru3lLVyzkmdF7iESKX+Gnz1RgKdWssjHvb4k
	 kEQI6wChoEmdX52EhOHEoq5wtvB5SNLdw5kJRx8VS7bhK2KfE19iQukg1b/oKx2aDF
	 +FrMnsREUc71IfiJU1nEZtRemlcL7M9xXUljBfNOklCyAybgn65Jgz4G79qS7rOdzr
	 7NSG82im18PZA4TT1q+jWNLWtm2VJnXB34qojfkNA/DskkD0S3wsSY7y3TQx396XSk
	 1C//vwZCZyS3g==
Received: from mail.finder.org (unknown [192.155.80.58])
	by greenhill.hpalace.com (Postfix) with ESMTPSA id 8FAF655A;
	Sat,  8 Feb 2025 16:03:27 +0000 (UTC)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 08 Feb 2025 08:03:27 -0800
From: Jared Finder <jared@finder.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: kees@kernel.org, gnoack@google.com, hanno@hboeck.de, jannh@google.com,
 jirislaby@kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] tty: Permit some TIOCL_SETSEL modes without
 CAP_SYS_ADMIN
In-Reply-To: <2025020812-refusing-selection-a717@gregkh>
References: <202501100850.5E4D0A5@keescook>
 <cd83bd96b0b536dd96965329e282122c@finder.org>
 <2025020812-refusing-selection-a717@gregkh>
Message-ID: <fceb96ee879249d18be0261e57388542@finder.org>
X-Sender: jared@finder.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-08 07:28, Greg KH wrote:
> On Sat, Feb 08, 2025 at 07:18:22AM -0800, Jared Finder wrote:
>> Hi, I'm the original reporter of this regression (noticed because it
>> impacted GNU Emacs) and I'm wondering if there's any traction on 
>> creating an
>> updated patch? This thread appears to have stalled out. I haven't seen 
>> any
>> reply for three weeks.
> 
> It's already in 6.14-rc1 as commit 2f83e38a095f ("tty: Permit some
> TIOCL_SETSEL modes without CAP_SYS_ADMIN").

Great! Is this expected to get backported to 6.7 through 6.13? I would 
like to note the expected resolution correctly in Emacs' bug tracker.

   -- MJF

