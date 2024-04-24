Return-Path: <stable+bounces-41327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CA48B01BE
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 08:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650751F2351B
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 06:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD93A156C62;
	Wed, 24 Apr 2024 06:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beX1R1ai"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAAF156C5D
	for <stable@vger.kernel.org>; Wed, 24 Apr 2024 06:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940082; cv=none; b=an2HiOo2yDZaoqlBjKJ/CM0hhEivTNKalw2M5xmcYgmk0sNe3JU+pSyvsWvbnxMCh8jzoSUgSL8aP11wpwxLuSe1mCWsL6sWBQ6bnM7rJ4d60iHAHKHBKw2LLdJm7eIArnZOpvxfroaDDeNEG7s1MjyOtsoO9ISHazPesWiPeGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940082; c=relaxed/simple;
	bh=GRY5qnR0WU+JWl7Bay/aaT2wZdOSpHk6deNBteJH3GM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HmG/kLGfp7xhdMkdv313l/VCPbNQMqfaWH3B+J3/582c7Jxw/9sidsrKODcFskr8QzSAUeVo48MOgQVSoYqJGcVVCiXN+tcf2Jxy+eyskqgHx5CNl7vwxgjsvz2VlxJsfbotXZxxSmbcoThVvQ4xV4LcUMQaov0dutUIHv67cIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beX1R1ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D9BC2BD11;
	Wed, 24 Apr 2024 06:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713940082;
	bh=GRY5qnR0WU+JWl7Bay/aaT2wZdOSpHk6deNBteJH3GM=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=beX1R1aiZU0Pd/X1hOgjxYH7kyuxoFq70K/cgbjng5SNwgGt0y6vafvlZboWn7es6
	 j003QNGiHSE8A+K+kkjvLUhIfwLPCn3WfA5yk/C6HhVdJ5v/rgfEljz49eAe6yB6Nk
	 hSn1p1LEPQjoTjqWe2RiHxfkVeiaqFvhu6Rfmnecv9rC7g7m3nw1rayI4YAq0YAlJl
	 5G3UcIjJ7GomWSZFZhZ3NaV9GiOmR7x0bXa4lPyYIMNJa02HczJ4/xtYXtSNujlgTW
	 fmgU8THtHcZYDdUO0fk1lheYrnmiEk5GOnt4HDsPa32H7KIOt9OoUQxGmiAgKVKbmx
	 danjlRFnSRzPQ==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id BE8811200032;
	Wed, 24 Apr 2024 02:28:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 24 Apr 2024 02:28:00 -0400
X-ME-Sender: <xms:cKYoZig_WuNXt-bhmgKO1POl6tGSsrcjrN5KoT-uN3YAl5ORRzPL1Q>
    <xme:cKYoZjDwABPsP-RvT8aWvDIJQ5oJ0xVXO5ay6e2enUAcRK-01CiPJlIPnlrH3HZA-
    QO4pJSXZUNgU3PT6RM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelvddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpeelvefgudeiheefledttedthfffgfekudegkeelffdtiedvgfevieet
    teekheffveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnh
    gupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:cKYoZqG80fK_cIQ4JMIoFvSr4BUvypxGgiF0k9Vhz07jB1mmLEYEBA>
    <xmx:cKYoZrRiFZpEKf4cddRAXWx0RPnz4L-WGk6rhkSVK4m2Kj_K--fzPQ>
    <xmx:cKYoZvyC_CNFosYCl6LctBUMFcfLrKfwmHTmoOrBqtF43k3BuwpKvQ>
    <xmx:cKYoZp7JaPlkCjc1PeffnTiCiai2frrGxsxv7RaxbwmJEVYsCwLVmg>
    <xmx:cKYoZsxdB6spLWSKWH48gEtYVyNxTmy_IoEXa6YZHN16-P1YewpWW4y0>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 82FAEB6008D; Wed, 24 Apr 2024 02:28:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-386-g4cb8e397f9-fm-20240415.001-g4cb8e397
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b1808bf4-a115-45d5-af18-35a0d71061a1@app.fastmail.com>
In-Reply-To: <20240423213858.137949890@linuxfoundation.org>
References: <20240423213855.696477232@linuxfoundation.org>
 <20240423213858.137949890@linuxfoundation.org>
Date: Wed, 24 Apr 2024 08:27:39 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Sasha Levin" <sashal@kernel.org>
Subject: Re: [PATCH 6.6 073/158] usb: pci-quirks: handle HAS_IOPORT dependency for AMD
 quirk
Content-Type: text/plain

On Tue, Apr 23, 2024, at 23:38, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Niklas Schnelle <schnelle@linux.ibm.com>
>
> [ Upstream commit 52e24f8c0a102ac76649c6b71224fadcc82bd5da ]
>
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. In the pci-quirks case the I/O port acceses are
> used in the quirks for several AMD south bridges, Add a config option
> for the AMD quirks to depend on HAS_IOPORT and #ifdef the quirk code.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Link: https://lore.kernel.org/r/20230911125653.1393895-3-schnelle@linux.ibm.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/usb/Kconfig           | 10 ++++++++++
>  drivers/usb/core/hcd-pci.c    |  3 +--
>  drivers/usb/host/pci-quirks.c |  2 ++
>  drivers/usb/host/pci-quirks.h | 30 ++++++++++++++++++++++--------
>  include/linux/usb/hcd.h       | 17 +++++++++++++++++
>  5 files changed, 52 insertions(+), 10 deletions(-)

There is no harm in backporting this one to 6.6, but there
is no need either since it is only a preparation for the coming
changes to asm/io.h.

Like the PCI quirks patch, I wouldn't backport it at all.
If you do want to keep it, be careful about backporting it
to older kernels, as it depends on fcbfe8121a45 ("Kconfig:
introduce HAS_IOPORT option and select it as necessary") from
linux-6.4.

    Arnd

