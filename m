Return-Path: <stable+bounces-272537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vghGGIa+TWrZ9gEAu9opvQ
	(envelope-from <stable+bounces-272537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 05:05:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D3A7214B6
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 05:05:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mbAkEL4G;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272537-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272537-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B087530309C7
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 03:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7842733A9E9;
	Wed,  8 Jul 2026 03:05:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078DE2EF67A
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 03:05:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479911; cv=none; b=YWM9MQcrlVmIJWvtg0I04ibdOCgitwwG9oUHgy7C6LRPojv/mrdQxSfOiUjdLGxTvmjnHazP/1+uMb1+k6bR406Me+wPcxT7Osn7MtBAs8HhD5c6Ff7jNhHiZ8/L3KoJ3jcZzy3PvA5KBdmm1bdiU4N1N9b1oL7wbYKl2elgggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479911; c=relaxed/simple;
	bh=lDkrN7TEV3W2iPCZlUY1PLvMiA3LImtRz8mNfzXbJ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8fpTdQJlFQKzWbGR8TllEEzDy60lsL8HJXHMLUSjnT3R2PUI8h3ZCmVj25LHaS/WLWuuEpFkIA1YIWLc1HX4SG9rM7z9+xTwg0YLt85Fc9LBtGptpozjtiz89+KTKnV6Io2FAzti1BtNk0zWOiQ5bCS2nARXnd0bi/+B15esRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbAkEL4G; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cace91f112so2291715ad.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 20:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783479909; x=1784084709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/2EyXuA0RqvzIxJQ42DvJAEkPUcEt3WncopO+pVd7fw=;
        b=mbAkEL4GFSp8e6YrS0IE+uKvRcWUsVULf40KYKwwmb6QaiarVWaBHRWcCEPlzRlVlf
         /ENBoLVey8pEK8T/bzXEbwyg/PJy5ftalRZUd1bBVKrE+VVFrGoxy0VOPnk6kGD8MTEc
         eAbjFQPMmfsNRaFopLP7KwGW0RRJn2nBFd8XX+ZydK/n8QvqwD2fwJbiGjgAlO3HmnW1
         b4YGrdnsUp/yfNkq66wnoZYmARQgB4+4AEI3N8u1uf+c/IpquX9OnpDSLzVW6lePKu8i
         pyTOX7PmuvaDDKf5hFYNQkXHf7TwnIf5b75d4RiNVe50KIMAj3w6nBTPCjjw9k3au4Mk
         v1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783479909; x=1784084709;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/2EyXuA0RqvzIxJQ42DvJAEkPUcEt3WncopO+pVd7fw=;
        b=HUWFWW5vxgg5kL6LPGKueRKo9AregP5zQcNLU8i0iVrjcJ57kLlcARVR+XChneFjI0
         l0+xKk8mnB+eoSyUThndbHwmRo45fJWdTCX9O8n8w6/hvR93cAb4MmdF7XBhhyGPom56
         RqJBjLCvV/x5w6rvGlFe0Z9NDVKMfhbzPCwLFnM0A21SdO2tIz/H0v5i+XXrtti3shxv
         Gvp9Sv88K8aUC3claYihdv+FmxrukoZm/WXuH454D6ooVyASGJN0olf6j6eaqA9s+cJ5
         0q07Gpg5e9CksiUZtcp7nEYnyRSNUCOYzGBQnPAfV0MAaXwwGkZMjrdnSez4CdX6HbYb
         0X+A==
X-Forwarded-Encrypted: i=1; AHgh+RqexrmVbDhOjk0TJ9q6Y4iGs/5mKFcC7ruScQwFExhfIiFSYSTUi3XN0m+kQmMug3YFNC02TvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhsnAM5kqRla4MX2dclgFKuD3XOIfi3uWO7aHX8QNeSzs/iLrM
	6f+lTs13Yrc2C1q6m5RCEjSThG/OnytpdlMMHAXvr1uasyVr1OPvwurHFbZzeSC5k0aCjA==
X-Gm-Gg: AfdE7cnPlspyk4uz4yFqjh5FfwNOamVX4MDUxAGrTLuMGtqILwGFnxW1TfGYY9XNkg9
	AyadWrD2C+AUkmabY7pPprQo1Vo0/Qp7cQk1pG0Dct3ezubkcnnZ/MUudDhg9ERMQFOkXJUkYS/
	7TQFn8fs0sQq+rC/4XJD5W/yYJTfkE6AddD2xHkuq9gtusqkwj35JBEVD8dy9TIIaLtbGb7Toxh
	04lKyidUEZxTdFQDP/m11kbx0TCMCcUR2P5Y3phHQ1uWGr8GcexrQ33cf5m/4lrgtJF6s45hA7O
	/kOoi4PgCJqp35uTEYMEg5kuevBZ39bqWv77VE8pNknhOTHNfFz4MDYX5lJCTSvAAWEbipqpWyW
	VZ+V6Q8URAQYqROMGK5sN47Wbsg6AuuB4ulPAGRJPc8+aUkpQ0fFhHqCe8MdCVQgu/urppbGjEZ
	Uusoe8ch4=
X-Received: by 2002:a17:903:1745:b0:2ca:ed41:d331 with SMTP id d9443c01a7336-2ccea5aaac6mr6489615ad.45.1783479909029;
        Tue, 07 Jul 2026 20:05:09 -0700 (PDT)
Received: from xiaowei ([2406:da18:1aa1:6600:7a60:aa58:4b0c:e1c0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5c804sm20225105ad.82.2026.07.07.20.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:05:08 -0700 (PDT)
Date: Wed, 8 Jul 2026 11:05:00 +0800
From: Kevin Hao <haokexin@gmail.com>
To: "Taedcke, Christian" <christian.taedcke-oss@weidmueller.com>
Cc: christian.taedcke@weidmueller.com,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Robert Hancock <robert.hancock@calian.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: macb: reprogram TBQP after shuffling the TX
 ring on link-up
Message-ID: <ak2-XJHVc3Cg6ZEk@xiaowei>
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
 <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com>
 <akzDQrmdYwHAMMmw@xiaowei>
 <8d53c3d9-7918-456c-8c27-e9d73c896452@weidmueller.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kyG29oqcChhEWuEU"
Content-Disposition: inline
In-Reply-To: <8d53c3d9-7918-456c-8c27-e9d73c896452@weidmueller.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272537-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:christian.taedcke-oss@weidmueller.com,m:christian.taedcke@weidmueller.com,m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:robert.hancock@calian.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,xiaowei:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8D3A7214B6


--kyG29oqcChhEWuEU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> I agree that the TRM says the transmit pointer is reset while TE is low. My
> question is whether this describes an internal pointer being reloaded from TBQP,
> or whether TBQP itself is restored to the original ring base.

The Zynq UltraScale TRM [1] describes the receive-buffer queue pointer as follows:

  An internal counter represents the receive-buffer queue pointer and it is not
  visible through the CPU interface.

I could not find a similar description for the transmit-buffer queue pointer,
but I believe it behaves the same way. From a software perspective, it should
be safe to assume that the TBQP is reset to point to the start of the transmit
descriptor list upon reset. This assumption is supported by the description
of the transmit_q_ptr (GEM) Register [2]:

  Reading this register returns the location of the descriptor currently being accessed.
  Since the DMA handles two frames at once, this may not necessarily be pointing to the
  current frame being transmitted.

[1] https://docs.amd.com/v/u/en-US/ug1085-zynq-ultrascale-trm
[2] https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/transmit_q_ptr-GEM-Register

Thanks,
Kevin

--kyG29oqcChhEWuEU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmpNvlsACgkQk1jtMN6u
sXEU6Qf9ENUqNjx8NFL9ReOVIph7o6p3txHaKrhJNj5yOldBQKaAhd3ulWrxdDo+
mBtBwyWjckjL6a66Nknb+FHUYCOSThofTjjzujesS5acHoyVDfTOn4ygarN4h3gx
Vo9tcn9AaxvJi91DZPS0pGMyZgw0LVgiWwBwW29/z/hjn2bnvVRh8+VuCCEUPwjE
32Zn7Oqe4fk6yghgBVebUAn1LcySVtLRm0Xxi2nJw6k4GFdeb8RJ8hTTz9jGrBz4
Tq4oYVreIMzMfcC3G4vqKpinByTiswzqoXhFDlPXup8X6zu6DecFqWdz3isOa+4D
A7RfNYlyO90plRZbnLNauVS1oQZucw==
=QDLt
-----END PGP SIGNATURE-----

--kyG29oqcChhEWuEU--

