Return-Path: <stable+bounces-238159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EFCFru932mOYQAAu9opvQ
	(envelope-from <stable+bounces-238159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:32:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0544A40667B
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CDB33011F3C
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8088C3E3C67;
	Wed, 15 Apr 2026 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyKO9KY5"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122733E3C7E
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776270659; cv=pass; b=cPI7DCMG/AWzpUgWCMjysleQgVcYcHllrB2Vhi8RlEOCryLmNVueenQ2xVouNFNAcqAR7uFXDKfEhAJ5uH0128gfO7TA+6nC3WVrcckmpRLmgGEb/BaA3fp3S6DcUMbnUdFrET7b/cdpxK4STdumc9FmqQ9rwYKpEiWNLpY6etc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776270659; c=relaxed/simple;
	bh=ICxNKX7qGv+Uf3H7xRWu5USDtER79xTLXqJUWpJ0IX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiL6mYukYahSwwvFKsglmam82ocD+l5kGSJpIbp5mThCsCZtZhoIurBuqZKWCX2PfRwkRhOyFUBtoWdrDP/eyQONhNtFdNjMUU30q5iiG664XRQ3GkZXzcQ5CfVSzo37YLwPApQ2rO11Z7ViOkix+Mcf/A4iW6vnY96phO0aCfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyKO9KY5; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64eaf8aa893so5988685d50.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 09:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776270657; cv=none;
        d=google.com; s=arc-20240605;
        b=PLQRQ3Ujl01n9n2m4E2/nc3KuNxqq7fqM19lKJuJ5RD8RDoKXy/N6CnOraN/SLRT2k
         Wh3I09v8NWuv8b8kp3WL2/1vNJojiQsEci4f+cJ+i++53nctrBYuq8jsY2KyFw3bOjFl
         mFYZO8bHXyJMmZOmnoQP4j+kYCbz4pY5XB8moOW367JyHO4lY4p+DDHF/EW7tYDgLx6t
         8oE11EWA3BwmWBcIZoHtwgNaIkL+q/qm3X9USCj9ZcpJciPQB6UViKMy9KjVf7w/l7n2
         38EnPd6s7Nt/5za45Y5vQTIfJeHdYBcbcP63sda3YMqRKsm7R4E1kVg8mZilIzuTKG95
         ShZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VBirzWvSR4/3IaGGAFPOCNOFJSU2QwGIXQOrszvzBn8=;
        fh=3yDnw+o/Zdi7reSedQ8GDN+pVAg8EGrruwYz/lmFaFU=;
        b=KsBCHxeZDNk0CHDilVlr/kP/xgABGzOld6bebOm6CoXzwTy9kIgVp2keZjzyiZHAm1
         RieeRQWvE3IPdtYSjZdw3bx2cLCqLT8nQ7g7euXlI13xNGA+Mb/w5GiHc52Y5TL+Yi7T
         3HCqpPuObqURtdbVSU13DUF5d2bjdmijH+m31+8PsANaG6ZkSh/aXVgTiW1inLhbLz5j
         GShQ9FprxhL2eZH27P34ZaewWRdk3oKuYuYQ1pCYUf8CqyuuIGvRhL4dFnIpIcZNwfXJ
         zWfmgzpwuXNeMigCH2kMJInkueXXuOue9Qx4gb6AWgDYmBpH5aQFpFgbjed7Ui1dgz+5
         3ecQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776270657; x=1776875457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBirzWvSR4/3IaGGAFPOCNOFJSU2QwGIXQOrszvzBn8=;
        b=lyKO9KY5xPXj9Kx0yZeRv3Bx6+mqRoqin6KCB6q19bEYuEMAU3v1JWG/LXxNnW6WNW
         Borax+ZrEblfE4NnQ5D9qBCO5f0aRMxTqvGR/NS8ZXstxwP8yJ13QDqH5A3C75OZyqr9
         6VVS3Y1Ngj93hQoaDDeKk4iltjj14Gsu5kWJo48nQQToRiYh+s3/q/3GYpAr4a32oP2f
         grMcxYpMqCRGKLmj1gV4i1rytI+hAi9GG79j6JEtenJBDGzz0CpbilyrgKItN8lqjHt0
         ts2MhMSittHI27QJTgL9lDUSW1fGaUEPJhoR6DWxxwQ41Bf4cpbp97tob0wzpg23cKUU
         JOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776270657; x=1776875457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VBirzWvSR4/3IaGGAFPOCNOFJSU2QwGIXQOrszvzBn8=;
        b=foK3PxEjgfPQS5JN38ypvQhjIfZVezzsv8FyeFJ0QTOOWfFcfbqcg9K5Je3Vk4/6fP
         ciO7ntq5C6fZDl75ZtUffNOnGYqw+ugceA8UoQ2LZtkRd0KIHfgQdfTIHZ7i6mgbJC6q
         VZGDEKn4E90xJHX9kKRYfeDZbEJ+zYrAIw0xnnroLt0WzGQaoZb/WNDARIje+jSRCTRF
         Z00oWO4NNjmrFD0rZ9H7GwKVAbHxkZNuhHX/3WLVB8fyJqoIIyx/PU5fO1zmO+GURFWG
         i/sMZEOC4T/fwXAnYtPYJlXWCbzfV/QVkSR0DaK2dcw3Z6UVPkCWLAFiv5OZ6xJQQrgL
         Zsnw==
X-Forwarded-Encrypted: i=1; AFNElJ98QNpRjVW5N1cjc6wXeM5hcDGaYkPdN9k/Hq9BEUh2r4mG1SFLWn5XZ514PXLPS/gUDnoWmRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCiLexqCh2lYEOE0HzPFm9P9IonuJ7d1CHzLjyLkILbgJHa5k/
	5MyvyE/TCo/9RrMGINdEDpGzMy826FF4WoREhGBs4jhAP8MP9/WNAZ+P/izDLnv0EIYnXKvKxmK
	4ixsrh5/R1I4YVdI+WH5bz/7FUnrRJHg=
X-Gm-Gg: AeBDieujFDsS1yAU7dnUX2xN5dolAW3YQHYMR0TkOE12aWJt83Q4q3Wwr132DvTWDRP
	yfH9sJzD8zatF/61r7QeBxiDo7cP26wGdu214aYgJIlX9wkKCYgZX4uJWzoJ1YmBCTqb8LZTsoh
	ZQKoCIYZFOPUp5raEw4Rf2yxLFSJveN7pnPKrXm6s/04puT9HNtx8LCprFig7JhWJ3jy0kGlUuC
	dpZrWRom8AxK7S3mleXuOrEX7CB2Tb6gbhHmnd6pQh6a0Ki/t4AVO51m7bYnuinzwHlroO+zmoC
	le12RoHbTXNCLNyCppLfDkJgsK6jIRfd/cBnl1RWhMSA2QM=
X-Received: by 2002:a05:690e:1699:b0:651:bb90:714d with SMTP id
 956f58d0204a3-651bb9071f9mr15120885d50.32.1776270657069; Wed, 15 Apr 2026
 09:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413182427.298513-1-michael.bommarito@gmail.com> <20260415161720.GN772670@horms.kernel.org>
In-Reply-To: <20260415161720.GN772670@horms.kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Wed, 15 Apr 2026 12:30:45 -0400
X-Gm-Features: AQROBzBJ7VPEuVDr74gDATAW33m2tupUjmRHD1ATtbA3VSrDaDdMAX-O608I1JE
Message-ID: <CAJJ9bXwQyd-cZ0h_FCNj29GZYpXyCBu444VhLGLZkf1bWYqoKQ@mail.gmail.com>
Subject: Re: [PATCH net] ixgbevf: fix use-after-free in VEPA multicast source pruning
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238159-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cancel_work.cocci:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,scan_drop_continue_loops.py:url,null_after_free.cocci:url]
X-Rspamd-Queue-Id: 0544A40667B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 12:17=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
> Sashiko flags a number of issues in the same function that
> do not seem related to your patch.
>
> I'd suggest looking over them if you are interested in
> follow-up work in this area.

Sure, I'd be happy to keep going here if you're open to more hardening
patches.

Two Qs for you:

1. Do you want smaller patches for each or bigger method-level patches?

2. Anything on my list below that you would *not* want me touching?
I'll combine with anything I can find from your Sashiko items

    1. line 104
       rule:   semgrep bug-on-in-net-code (CWE-617)
       match:  BUG_ON(!test_bit(__IXGBEVF_SERVICE_SCHED,
&adapter->state))
       where:  ixgbevf_service_event_schedule()
       status: untriaged

    2. lines 1219-1225
       rule:   net-drop-continue-in-loop + scan_drop_continue_loops.py
       match:  VEPA multicast pruning kfree_skb + continue (UAF)
       where:  ixgbevf_clean_rx_irq()
       status: SHIPPED as commit ca62ac02b30d (this patch)

    3. line 2769
       rule:   semgrep signed-int-as-size-param-kmalloc
       match:  q_vector =3D kzalloc(size, GFP_KERNEL)  (signed size)
       status: untriaged

    4. line 3452
       rule:   semgrep signed-int-as-size-param-kmalloc
       match:  tx_ring->tx_buffer_info =3D vmalloc(size)  (signed size)
       status: untriaged

    5. line 3530
       rule:   semgrep signed-int-as-size-param-kmalloc
       match:  rx_ring->rx_buffer_info =3D vmalloc(size)  (signed size)
       status: untriaged

    6. line 4114
       rule:   semgrep narrow-accumulator-overflow
       match:  i +=3D tx_ring->count;
       status: untriaged

    7. line 4189
       rule:   semgrep narrow-accumulator-overflow
       match:  count +=3D TXD_USE_COUNT(skb_frag_size(frag));
       status: untriaged

    8. line 4192
       rule:   semgrep narrow-accumulator-overflow
       match:  count +=3D skb_shinfo(skb)->nr_frags;
       status: untriaged

    9. line 4695
       rule:   coccinelle cancel_work.cocci
       match:  INIT_WORK(&adapter->service_task, ixgbevf_service_task)
               with no matching cancel_work_sync on teardown path
       status: untriaged

   10. line 4752
       rule:   coccinelle null_after_free.cocci
       where:  ixgbevf_probe() err_dma path
       status: untriaged

   11. line 4795
       rule:   coccinelle null_after_free.cocci
       where:  ixgbevf_remove()
       status: untriaged

