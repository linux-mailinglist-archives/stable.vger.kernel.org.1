Return-Path: <stable+bounces-116807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AFBA3A36E
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 18:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755473B6000
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB2D26F474;
	Tue, 18 Feb 2025 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="OIkztm9I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lW8oanri"
X-Original-To: stable@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDEB26F46A;
	Tue, 18 Feb 2025 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897901; cv=none; b=HfimXFa8sBEyNdxYFYxKVMhjOK2oaGra25YXbWarXT3cpViMGEVHn65QnAQ5kLluNubZ9XEcd7lEQJrWr2TcluCJ9cCs1XFBcbiVdA6lv9t3/8XnYO/iTTNGXiSnmD15reYunZ7QxFvXVnmYywoGcgtbdDqL/AGYqFF/gQ+q7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897901; c=relaxed/simple;
	bh=CGmdvdDU/PynLCC51mKFw/25ge/gsTJ3wantBbxOtPA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Mby2cF2dGnYkK/1SdK3wGdK8Fy4Govy+dwlDex2qcTPeN/i2cBtk83Xzu3cNXHwLKjn0/9Ab4uL9lT4em9jm4sEnahJwoII6Xu8zfzh7uO3M2hVMaR6h/NM6ALWdCM7xa6Pg40P4vJI0PKTW/1tBA+3OyyeCRbzZI4H61RfKI8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=OIkztm9I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lW8oanri; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CDCF413808BC;
	Tue, 18 Feb 2025 11:58:16 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-04.internal (MEProxy); Tue, 18 Feb 2025 11:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1739897896;
	 x=1739984296; bh=aNAlA8hxRpyCp2MQ3TxnR2uvSEYOdSCvL4wn3IpX5pI=; b=
	OIkztm9IINN51EQQpkqZjo+t1/Hu5t+iIAZJRPTxBdjwHrX/Nl+4IarLUdcuhrmG
	VH72YWC/ZJL0M2cV9ZpvVE2achxvR2nowtGujzYCfCOBmUau2yW7TSVYT/peeiMw
	9JUXhHlW/2MkxsSllk6dqR8A9GPHEW/B7VMqwmaJdH8CQr5DTfmFMx7qaXQqa+3I
	099jRNWIXQu/Lw2Hn24IWeD95C0NkMy+z59v3FvnaC3MlxtSIuSDZhmxrG25WqL0
	KC63urPDqb11zN8NJnFoFoq/e2J8hlB1RhJDp8wZr5fuYfHNY8S2xJP4MOUavhzH
	EzVXXy3aZtomSlQBbi1jxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739897896; x=
	1739984296; bh=aNAlA8hxRpyCp2MQ3TxnR2uvSEYOdSCvL4wn3IpX5pI=; b=l
	W8oanriWgtsuobHLGPS2P2UseU45uRT5mKqNdYrPq7Pi2XjhpQLKw2tl7E13TKhP
	o4FHb0+00mr1EprMJfOs9kYJ/bIDCpImVbciWMz3ttpXsA61MQqDvNNG4hH0OCMN
	PpiyEC7cPuBTTmZ8r1C54VBD6q9XZWbdXew5BPC1IpEVLo8EyViZ7gDzyOyt7xPC
	dY/EUly9EWC4HE/stByuOEuR2Vql8k7U8utHKsd6cLXqS8gR3EGSMLTBSSDql30i
	SNvafbPJbilXRcRfwvqDyUPr9WS662lOOL8xcWeC2mEVcc+6G/stT3npite5Sz7q
	NRazv9OK0lmDbGAdk/p4g==
X-ME-Sender: <xms:KLy0ZyywSJdNf-UFpG4wDImNB8Fd46hYu5kGcHPU851eqbQHpzQoNg>
    <xme:KLy0Z-SmwJCw8mePwjAqJyp-Tb7SbJ5yz7tjcdQEwMVirbEKFlhEfBlj_CaXrYnH8
    DunanqS2NXOsZTI-CU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhephfeuvdehteeghedt
    hedtveehuddvjeejgffgieejvdegkefhfeelheekhedvffehnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhv
    ohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehlkhestgdqqdgvrdguvgdprhgtphhtthhopegslhgvuhhnghes
    tghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepsghouggurghhkeejleegsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepjhhthhhivghssehgohhoghhlvgdrtghomhdprhgtphht
    thhopehsrghrrghnhigrrdhgohhprghlsehinhhtvghlrdgtohhmpdhrtghpthhtohepug
    hmihhtrhihrdgsrghrhihshhhkohhvsehlihhnrghrohdrohhrghdprhgtphhtthhopehh
    vghikhhkihdrkhhrohhgvghruhhssehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpth
    htohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KLy0Z0U_iEENkeePDPy9VGPg0xnWzlZQN3uWL9yLN0d8CjYLCL_04A>
    <xmx:KLy0Z4haWr5l3EfZrp56aqFTrfiZLZ4vxk0O4CNo_DkRy9k4dNcPVA>
    <xmx:KLy0Z0CActtgex7uX4rDqBg7wLBhZueRFQHL0n5ANF7_pboNJS2uGA>
    <xmx:KLy0Z5K34IqwNwssrKiMbeauqUMP8q3gCwQYUYDaeDHesg_rbCpiww>
    <xmx:KLy0Z46ieUoqvemKyVBHYKX7EvblXx1hxkUTWFp-9Zg6auIHdEaxwJ2d>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F101B3C0066; Tue, 18 Feb 2025 11:58:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Feb 2025 11:57:55 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Fedor Pchelkin" <boddah8794@gmail.com>,
 "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 "Christian A. Ehrhardt" <lk@c--e.de>
Cc: "Greg KH" <gregkh@linuxfoundation.org>,
 "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
 "Benson Leung" <bleung@chromium.org>, "Jameson Thies" <jthies@google.com>,
 "Saranya Gopal" <saranya.gopal@intel.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <c48d6d73-73d6-4df6-8e9c-c8f2ecdd654a@app.fastmail.com>
In-Reply-To: <20250206184327.16308-3-boddah8794@gmail.com>
References: <20250206184327.16308-1-boddah8794@gmail.com>
 <20250206184327.16308-3-boddah8794@gmail.com>
Subject: Re: [PATCH RFC 2/2] usb: typec: ucsi: increase timeout for PPM reset
 operations
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi  Fedor,

On Thu, Feb 6, 2025, at 1:43 PM, Fedor Pchelkin wrote:
> It is observed that on some systems an initial PPM reset during the boot
> phase can trigger a timeout:
>
> [    6.482546] ucsi_acpi USBC000:00: failed to reset PPM!
> [    6.482551] ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed
>
> Still, increasing the timeout value, albeit being the most straightforward
> solution, eliminates the problem: the initial PPM reset may take up to
> ~8000-10000ms on some Lenovo laptops. When it is reset after the above
> period of time (or even if ucsi_reset_ppm() is not called overall), UCSI
> works as expected.
>
> Moreover, if the ucsi_acpi module is loaded/unloaded manually after the
> system has booted, reading the CCI values and resetting the PPM works
> perfectly, without any timeout. Thus it's only a boot-time issue.
>
> The reason for this behavior is not clear but it may be the consequence
> of some tricks that the firmware performs or be an actual firmware bug.
> As a workaround, increase the timeout to avoid failing the UCSI
> initialization prematurely.
>

Could you let me know which Lenovo platform(s) you see the issue on?

I don't have any concerns with the patch below, but if the platform is in the Linux program I can reach out to the FW team and try to determine if there's an expected time needed (and how close we are to it).

Thanks

Mark

> Fixes: b1b59e16075f ("usb: typec: ucsi: Increase command completion 
> timeout value")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <boddah8794@gmail.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/typec/ucsi/ucsi.c 
> b/drivers/usb/typec/ucsi/ucsi.c
> index 0fe1476f4c29..7a56d3f840d7 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -25,7 +25,7 @@
>   * difficult to estimate the time it takes for the system to process 
> the command
>   * before it is actually passed to the PPM.
>   */
> -#define UCSI_TIMEOUT_MS		5000
> +#define UCSI_TIMEOUT_MS		10000
> 
>  /*
>   * UCSI_SWAP_TIMEOUT_MS - Timeout for role swap requests
> -- 
> 2.48.1

