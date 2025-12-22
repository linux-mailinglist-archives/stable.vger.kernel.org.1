Return-Path: <stable+bounces-203239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F34ACD71C2
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 21:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1FC63001016
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 20:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D9234B404;
	Mon, 22 Dec 2025 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="vOZu9CQa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bmFBy9tG"
X-Original-To: stable@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4A834B1A8;
	Mon, 22 Dec 2025 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766436019; cv=none; b=mhRLXmu4IrHIklbpPGvGTt5vz1meoy35TRlUVQGwank0RfVedrnbwntajN308sU4H7iNIrPjsXyFgkgxmkF14cNoG1CBvSnyUxIGTt3O4zfOSpb2Ey2ES9cQKahBL2HvbuTjgw/SHMP+Oq0pryVjawb88MHkudNN8rXE7XFmqLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766436019; c=relaxed/simple;
	bh=N0zn4cHvKm7VJ98W7PedgA2cDBuNj2GPeVb/NK7xXyo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XBXUaeFcyhNqYW/xljT80qFkximoOdo0x+zX8FzHVuod6HDMfI6//XtokrLLQ00Efc4ux4iYkNHdI5xo4TWWsV5RH4RSRtpEJOJJdv0uaTLHasHvPdT1XWq0MAKZ3UErsEoEQYi3cPLneRhB/kVUaou92Drd82AkJejeZcVoOzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=vOZu9CQa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bmFBy9tG; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 9BDD7EC0194;
	Mon, 22 Dec 2025 15:40:15 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 22 Dec 2025 15:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766436015;
	 x=1766522415; bh=EN4pCufu2q6Xwutucsrg9lJLUyx+d9SWGvm7ddYMjq8=; b=
	vOZu9CQaVyhsyMBx0oR6Dr4REsGfNPHpjpPxrNpWgUX+IZrVtycOcyZ95PVmzspz
	qsDevSbjybKVGCUpsKji0Jniv7ovUpld09XzI0AS7w+sOfqZlDCrVeg+Z+Exq6eL
	d9O8vUAa47R95R3WdcWJXOjcXNQIwAOf1r3KCYj5qB1K7wswphhNlGoyKtljVej6
	d2xfgDNuR3j9HIvGSaledqVZKIihb8OtocB+6PzH5FvPnv1KeHwqhVATXte4u4i6
	hoIr86gMp1nGkmjVuf0XdySN+4UzGFMZ/ugoyZ8rnfzF0dl98QI4ELq+lcP4CNu4
	V7iv2jX/rHRLh3DAvsh02Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766436015; x=
	1766522415; bh=EN4pCufu2q6Xwutucsrg9lJLUyx+d9SWGvm7ddYMjq8=; b=b
	mFBy9tGflMu6FrNNV/y4yX1DwGoFSeezt6IQGkTDWjwfqOKjtKb0YML26oNYmlH+
	HIT+j5e1kHhX5hK6OaG+UO2iumovbI5RfeDA4HE7/A4IGv2Y/LPIiAmkwCcn4BFl
	4XWV6DY53IW7c8i9auS0Os3RiRdMVf2wWtY+t1pD9eCzYRYaOGK2mIjGxKI5dMi9
	XiXuddaZpm3AKLEuuhMdJ8bvae5k2vtEyGYIgF7o2pG3Bgjq8LnF3lgmH9I+H3Yo
	euq86Z1MWkjlFGfUDf1n4LREMpNEIum9Z9UoOpyb9s8sQDaBqRcyPDzw6lsMtAGw
	3dNehUWkUED2kBAj25lpQ==
X-ME-Sender: <xms:r6xJaTu-9uHiw00Z0X4qncuErV0WSRSO2SnKFB1xZo0r6d8oC89DBw>
    <xme:r6xJafTU6kg2JMYKycWy0OkqH9Y3GlGHNbNvkdXukXWVP-X166Z-Ud3Vq2UYaQ9eO
    9SPTgJy7BSu_lzq1RDcIql6ZWB6pbkhWIipoYQCg3LUuW7A5F0bOgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehjeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehlmhgssehishhovhgrlhgvnhhtrdgtohhmpdhrtghpthhtoheprghmih
    htsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhu
    nhgurghtihhonhdrohhrghdprhgtphhtthhopehvihhrthhurghlihiirghtihhonheslh
    hishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:r6xJaVSrim3HO_jK2r64-_32htb1lSCD5aMTLE0-hBOGdvZSEwPaDA>
    <xmx:r6xJaRBvNgIM8mqBDHWETnKlfg6Nw18D7Z-oIt1qmZLoe7N6Ln7FCA>
    <xmx:r6xJadGF-QZlyxSvKezct0ipaLw1kRHvRQmgYvlUUf480sYCcqtuPA>
    <xmx:r6xJaTAu00-JxzsL3DAhYc-7cotL7ph1Lqk_8Dx43kGqMX4kKbSGnA>
    <xmx:r6xJaf6k6NcN-GF5PedB_a1_zeeXt5DsOyyrw6O9wUMuZAjlssgrZcVL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 18A71700069; Mon, 22 Dec 2025 15:40:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ag3Cik6rCkEF
Date: Mon, 22 Dec 2025 21:39:45 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lorenz Bauer" <lmb@isovalent.com>
Cc: "Amit Shah" <amit@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <6ef2f777-dd96-4b07-bd4d-0567705bf837@app.fastmail.com>
In-Reply-To: 
 <CAN+4W8hAqVxbr040b_+Q-zF0Dv0utoj_UfwH+4LVk=Vx2TTFZA@mail.gmail.com>
References: 
 <20251222-virtio-console-lost-wakeup-v2-1-5de93cb3f1c1@isovalent.com>
 <abdeaef1-e6d4-43c3-b8c4-d5f0c645a169@app.fastmail.com>
 <CAN+4W8hAqVxbr040b_+Q-zF0Dv0utoj_UfwH+4LVk=Vx2TTFZA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: console: fix lost wakeup when device is written and
 polled
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025, at 17:23, Lorenz Bauer wrote:
> On Mon, Dec 22, 2025 at 5:13=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> On Mon, Dec 22, 2025, at 17:04, Lorenz Bauer wrote:
>> > @@ -1705,6 +1713,10 @@ static void out_intr(struct virtqueue *vq)
>> >               return;
>> >       }
>> >
>> > +     spin_lock_irqsave(&port->outvq_lock, flags);
>> > +     reclaim_consumed_buffers(port);
>> > +     spin_unlock_irqrestore(&port->outvq_lock, flags);
>> > +
>> >       wake_up_interruptible(&port->waitqueue);
>>
>> The callback seems to always be called with interrupts
>> disabled(), so here it's safe to use spin_lock() instead
>> of spin_lock_irqsave().
>
> This is pretty much just copied from in_intr which also uses _irqsave.
> I think it makes sense to stick to that for consistency's sake. What
> do you think?

The usual rule is that you must use spin_lock_irqsave() if
the function can be called from either interrupt or non-interrupt
context. It's also safe to be used if you are not sure.

However, in interrupt handlers you usually want to use the
plain spin_lock() both for efficiency reasons and to document
the calling conventions.

     Arnd

