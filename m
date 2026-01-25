Return-Path: <stable+bounces-211476-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG0sC1B3dWmqFQEAu9opvQ
	(envelope-from <stable+bounces-211476-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 02:52:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB707F74A
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 02:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3767630022CD
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 01:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913CD1A2C04;
	Sun, 25 Jan 2026 01:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZvqesz7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D821922FD
	for <stable@vger.kernel.org>; Sun, 25 Jan 2026 01:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769305931; cv=pass; b=rDt/VmkmidjsiCUZ5yeBAkZKeJAWjtI9PQvzSbOVixyB+bFY18was23+ujAAx5dUe68paJnbweI86SbxRvJHj3N2LkekqEK4OnptDEnZ93LJh1p/IMV7p50gstwwOfVDtOIy4d7L5yZLFl/ZZndsloPmWqeSZZwMyUC6VuEwt9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769305931; c=relaxed/simple;
	bh=PlYLsq+ZaimvGGy4x/AZzbOrBDCOqAHYQURfifOmu3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxpQ5A66byvRL8GXUTyxrB+svztbeYADarlSykmz67qHb7HXOPU55+RviUuDYW+ld54wON2P2cggO2v4vTajrKQBzbf9RBQzMSVuWepkw/jdiVPpRMR2rlpv9umnnGo1GHenrRc1hN3gO7C4c+g9MV/C9YXCDh7ucdFS/7/fvUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZvqesz7; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-652fdd043f9so6151081a12.1
        for <stable@vger.kernel.org>; Sat, 24 Jan 2026 17:52:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769305928; cv=none;
        d=google.com; s=arc-20240605;
        b=lYVXUBWbDnUHxKeYW264TpgYvMYt/NeomaEPUmB4cRyc3Mj+G2mSmByR25hIIjd02y
         0/TseXzILRh9STiIYwom7C3OpmrV6nO6KXQQ+PDdQEwKfWjANJUtTFeww+W1xX6IJO0L
         YZr21FVhaBcrmMPqkJ+In2nE3U5fRF5HlIMAzErOHv8D4ZKG6dOzr1Z+e+jQdY0rBygE
         4fYFRY7HeBHFbf3QXaLJPnNytpo18vzGlW9nySSZzMd7kAUczbdBGZBs8wE2q37m5mIE
         diUci13UrjgMsdmR5taC3lJdqG5ZNN5T0j7//uz0dmP0jYwEQ21sFjjCoil1G3KxFQeR
         ZbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PlYLsq+ZaimvGGy4x/AZzbOrBDCOqAHYQURfifOmu3M=;
        fh=VVia0Jo97xaS07p81AXvnWcRlLATyX/H89HySMWQma0=;
        b=eiY7FHSiSFJruRlyEeobHDTArsnZiDlMc1O9mJTxbOBJStD1QknCNDUWdFlBR5KwrH
         yxka7drh/0gj+ArG85AlBYkHXfeUY0jdwqDBnDYg2OpVP8/SC+rZNSdCGv6nAe7J8Xwz
         rnaBOrJvk3jUaKURDrY8Pfett+Fbv37NPc4zJl6zUA0FEwFYOcMEJeM2CQnfiTzfJP63
         puKUTTXWu4BY4Mb1DDhW5lh/rQVET+1cUW2Gr+4fxoOK1NeyiTscXAkZ2xtk+XgTmQUp
         b/ZE2q3swPrIT0UyA/Mie2iRQEaz1rrILhXx2Wp/oE4Pw9jF49xxc4yuLf+2GgFaT8IU
         cHTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769305928; x=1769910728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlYLsq+ZaimvGGy4x/AZzbOrBDCOqAHYQURfifOmu3M=;
        b=mZvqesz7WBI4NOfJM0Y3mEH9qPWH9jqCKiH/D6irpS+UTiqTzXCErRUDaPljYYBmfb
         wJwwQmedEWrffFjAMlveDurUFPn+xwA0GkYhs3uBu/0IudtYdjHrkC841qFmjyctH33b
         wCIL+9QFf2sj6Fjj1ORE51jGahlX00ogBSaSX950EuHO1tc02NtNcyr08nupkxrU1+6w
         9LCnqox2BQCKgcfTfbPo67q3v+BLRPGGE4ac486Dt+KObCZgEvAA+VMgTyowVXpum6Yt
         9mhLNh0fq+SfkxAFwpFliNMTpBpcR9w+C0sCDwDeSy9krh+4kqniIdBE3HeDT0IUCz/G
         SLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769305928; x=1769910728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PlYLsq+ZaimvGGy4x/AZzbOrBDCOqAHYQURfifOmu3M=;
        b=cyokSQOIZjMpVN0a+m3Oat7hMhURDbw+nNQoH27tp6A7kHHe3qlaPt5Scc0RjpWMzR
         hBjbtGmFWPjdQmuI9RyAPKNnqebiShXywzgQsbu7ZVDjNzrYI9GgICOMpZRWnX298ESj
         qlEQtDmPDw8sVzXYk2i0QsUlfDT1Fk3g0xip4fJzLxAnJZO3FX7ZaS1arpRDmc24pY6D
         Pdn1AsYB/8Hk5bvEnxHmn7ChzqOcL8TXY7RWCziTRUvImYu+M9T5aoEYqjoUe9P640Hh
         riGv/z5YJwIHuFKbGQZedbsSVPSZtkj8Qcw53haQdFOnJJ4p2MtyzIf9gPCUn8NJAul3
         0WKA==
X-Forwarded-Encrypted: i=1; AJvYcCVvurSKvgxLa89vxmuNsRX8FvVfB9Fhw6p1extF3zw3B20NY0qtUKaIg5U68//SPV90Qf44BsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4oBbCW1SJHTzhhzEr1/IlivxFItMX8OIyDsVz2QbKUBGiC26o
	HkAdrrPygcdVjH4X5ifeMO0w4GRIbsI6rqTmEycHAl5dPqKIaXKGmfklHaLHin4TRzXYfVtd4dA
	qdh8+Qq/36WBrrAiwzZ4THWQFWbprmdprqq77
X-Gm-Gg: AZuq6aLrT06lPwHGIUjWpMkd2zo7LirszGAKvsjS8BjP1IEGN37X60fCe2bwvoPeH/q
	lSiMg3fkgELffE6nkVTBKGb6NNyAZlN/hDMkHKNpPBCVMq5eu9EZzC9y1N86cQ+y8M+qQadZJFv
	FiMnYDB7axjtVbIgKwfM2Bup3L9pF+ZZtAymySYxOQ0IORopRW/93Bao78aFCbpKx1I/URnzjDS
	SJDHXjpIBPQEcvtf+fRa1seFn36NDmYfNsNfjs2s54pVguNSN2VHXPFfS5MD1hq6yGC0e0W
X-Received: by 2002:a17:907:7fa5:b0:b83:9767:c8ba with SMTP id
 a640c23a62f3a-b8d3fa46b56mr20568766b.17.1769305928218; Sat, 24 Jan 2026
 17:52:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216084435.903880-1-joonwonkang@google.com>
In-Reply-To: <20251216084435.903880-1-joonwonkang@google.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sat, 24 Jan 2026 19:51:56 -0600
X-Gm-Features: AZwV_QgfJ7ZoZKJfJtfMnG9UgnvLcakyLw1e6I-9FHCPh1WHWNUXkt4FQsL0c7c
Message-ID: <CABb+yY2ucPfFhDq3hK6UR3QmqyA+950vkDx0QFtJB+_Yzw66SQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 RESEND] mailbox: Make mbox_send_message() return error
 code when tx fails
To: Joonwon Kang <joonwonkang@google.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211476-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jassisinghbrar@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBB707F74A
X-Rspamd-Action: no action

On Tue, Dec 16, 2025 at 2:44=E2=80=AFAM Joonwon Kang <joonwonkang@google.co=
m> wrote:
>
> Previously, when the mailbox controller failed transmitting message, the
> error code was only passed to the client's tx done handler and not to
> mbox_send_message(). For this reason, the function could return a false
> success. This commit resolves the issue by introducing the tx status and
> checking it before mbox_send_message() returns.
>
A client submitted the message, and that client gets the actual
status. mbox_send_message does not (can not) tell if the message was
successfully sent or not. For example, consider non-blocking mode when
mbox_send_message() immediately returns after simply placing the
message in the fifo. It returns 0, but still the message transmission
may fail when its turn comes. So I think it is fine as is.
Thanks,
Jassi

