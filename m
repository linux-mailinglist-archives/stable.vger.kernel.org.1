Return-Path: <stable+bounces-75843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA11975572
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 16:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21981C22CA8
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70EE19F124;
	Wed, 11 Sep 2024 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="u/+8qiZ9"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D210F192B88;
	Wed, 11 Sep 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065111; cv=none; b=MEefkIo5iTw2sT6K5iL7gcHcjtRcjSjTz341CCTXTdDkX0L0KZhVO3ljs55vR4EVCqIAQ+VlPni16yJw7zxqaHiK5gtnnrYC6w4/mPW5nkA0lOcJ7dHqkf284Y+A8aNBvOgkc9WB5q2lTCOd3NplU6w0eNe66Tdyv66nIDQUozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065111; c=relaxed/simple;
	bh=gfWKMePXNCFVDvze8VMVK6kMx9WF1reISt4viCSBPNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfhSq0fPSB+hXPPYr3R4s10OJeZVvhYz2SjgQRXmYP9ELLdhxrdpHUM7gylmVzyA4V4uUmFO5Fng13gqH73vIvD9Tzg6eYFjq3OxhvpQPGpSaG5pIMvjbmiNw5zmFyPk7IiQSWLgixDOG8mJNcMN69MiryjnoDv9e1L3nVILSQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=u/+8qiZ9; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=kazUhr9+CMKnxrHDG4LG25lGRvg5PhMm3O1ZvwtY70I=;
	t=1726065109; x=1726497109; b=u/+8qiZ9bzv1UOEp9alY0TfTT1Cc6pn8ZIbmydUn39R40b4
	pYUPt3nkFo+fkvShBZFWSlpgUmWwdrUD9IEojO5WdDwrFjsZd5sG0qhmjguwbbktHmi5gGpVgFleq
	UXLocCYjdHaY1xB1J1CdHJtzT0gR77QTqdv6qUfHOOV9hvLg/U5j5l2k1Ud2PVJaU/c7GGx+KqdpO
	14b82Zbef9yvaD6APyT6PDO9YqPXcoWWb9qA4x3NlYVIv5QFbx2Lu3nHkr7udgd9KzVDj3XNf16zG
	f4ad5kofkJI1zPjIt/TFC3DnZbqzADeDRLVU46YE9h8EV3Mm4vizvhkRUMPjwwTA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1soONj-00022u-U2; Wed, 11 Sep 2024 16:31:44 +0200
Message-ID: <f4c222e2-cf94-44ec-bc69-0ab758bfb3fa@leemhuis.info>
Date: Wed, 11 Sep 2024 16:31:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable-6.10 regression] Revert "soundwire: stream: fix
 programming slave ports for non-continous port maps"
To: Greg KH <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Cc: vkoul@kernel.org, yung-chuan.liao@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, krzysztof.kozlowski@linaro.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240910124009.10183-1-peter.ujfalusi@linux.intel.com>
 <febaa630-7bf4-4bb8-8bcf-a185f1b2ed65@linux.intel.com>
 <2024091130-detail-remix-34f7@gregkh>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <2024091130-detail-remix-34f7@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1726065109;ac2ccdb3;
X-HE-SMSGID: 1soONj-00022u-U2

On 11.09.24 14:31, Greg KH wrote:
> On Tue, Sep 10, 2024 at 04:02:29PM +0300, Péter Ujfalusi wrote:
>>> The reverted patch causes major regression on soundwire causing all audio
>>> to fail.
>>> Interestingly the patch is only in 6.10.8 and 6.10.9, not in mainline or linux-next.
> 
> Really?  Commit ab8d66d132bc ("soundwire: stream: fix programming slave
> ports for non-continous port maps") is in Linus's tree, why isn't it
> being reverted there first?

FWIW, the revert should land in mainline tomorrow afaics:
https://lore.kernel.org/all/ZuFcBcJztAgicjNt@vaman/

BTW, in case anyone cares: I think this is another report about the
problem, this time with 6.6.y:
https://bugzilla.kernel.org/show_bug.cgi?id=219256

Ciao, Thorsten

