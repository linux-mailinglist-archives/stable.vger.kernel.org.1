Return-Path: <stable+bounces-225217-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLFfEV0ts2ksSwAAu9opvQ
	(envelope-from <stable+bounces-225217-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 22:17:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9B7279DE5
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 22:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 948D330F0E73
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5801F3AB289;
	Thu, 12 Mar 2026 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOOEWv6w"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1BC38B131
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350096; cv=none; b=dOqiX7bg0M1dyuNqzrM3rkhRDmFo/WQS9Fp7WSCKQ+64pBhIxL2mDHUvKiuJ7SYjh+wdlii0UtN3OJtR/crQbbSDHEn+5gE2d4rPDT68GRf98Y9ydWGdgEqpOCFp2KnVsbgCZkJQ1wVsQz1HZMv3wJNr6+YV/bI7RdmmxXUDEAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350096; c=relaxed/simple;
	bh=X3MdWL87ZzxZkXkkruu29q57p5D+vJjyl1/uv2cRCpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+BSMsCg39IGWi1Q6clvH7CIMXgt01eGBiRJ/AeOhshjNI7REgUvA5hA0CUYtnHATM403biLD9j1Ozh9HOWkgazP20tSWeiA9vhtG7/SIR5cKlfsdOdvY3mWW4l62SEexIUhP8kwjzVmGZl0yqOiT7IaA6qoWTnAmocGY4C4VYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOOEWv6w; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cd81963e73so159447085a.2
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773350093; x=1773954893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKhF79fkv9q8iYiNyqivBtEgraUUrd0jdUKOsg5fKR8=;
        b=DOOEWv6wgtOPa3X8woPqxL6tIO6P87dOgn7mUpdD0im7Cyp5i9oL5zAuQQZgk4u1Pu
         m8JB+5N622MMLhn1h5nG+ro5/Vc6SAhALkrdF01NbQ+5UXKXIS9gRLtu9IV5gGmRmpgy
         A9Uu//FhGdq4jh0i80xftEBtLqHGWCxCp0ttXdaYCHzRCLh49O1vIUAkmaQZH/tjd5pE
         SZna2wBvyP8c0rvlxK4hfBc3PF76PrDvVexg6NekeCmhf7b0JZJeWiehVj6/3VnNPN/z
         TBG56JmEm5mohAgXr8bGN49/TB5nszRd+8iuxy6RIxeremT9Raufb5mQzBJ/s0Ukibzg
         LN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773350093; x=1773954893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QKhF79fkv9q8iYiNyqivBtEgraUUrd0jdUKOsg5fKR8=;
        b=S7Dbr9/m0chwoN81T1Va+FJ0zTHL3EwIOL/DVzF6xDGHBS9u15Z9g84KbhU/+sFa8r
         MYbc5Ai3MtxKgSO4ejVyvwKHhYzhtcZQB7ng/Hc8Jri4yWrOzwnCdJleYlDPvR1vJnoo
         GAwum/IZizJsVT5zf/WNhkFnTXMdnxZfybC06NC96xr5Ca4xLxna2hp1mQmjzmI+Np/x
         8QBKogNDnCJukvP50YcFJdq8RjL4jWJ9LcwkqZXbTYlK52M5DkXiLrb6bDycKKcAu+ZC
         Gyr9wq7seNvFBIXSZnx4X5/ouKOXV4AIMsKIqrBLOgGaaQ9zzTi1OwrLDn6zjHIpm+3n
         /IWA==
X-Forwarded-Encrypted: i=1; AJvYcCVnIlYqUBKfodcAJ8hZovuCc0d1s5T91+jF13m9mFkJ/LW1uYrACN3lSxf3ivgnT9oi9dglMDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkbZl1FQNd4dc5cTxUATbzOW2n1MNgym69EOijUkBNoMTsS5MU
	2tkh5C7OZL+qcXCp1h7L3nVvNJ+XN72T6Z76zZirDfei3uWVPj6gjggP
X-Gm-Gg: ATEYQzzKSerJxG0NWYdMGx7fo1Xs+IgtjtVHLNFH9HnoWLH0sYz88iqzIRc4+ln4Ck8
	8EcbDfM1pp+f9q1787NgqyYVZ6BZpGfVSJ7iOI5g3IBHSmDVPaxflMZWcb0afoQa1RoTNrZnfa5
	lfIMSKJTzNxET6jiI3h98yp98OdLx3QsvZhdWLCdPpqhtHLmICrCowyoIRApPqu3R2NOfhWJqRa
	idj9JAT+6/Pnnb5OArajI9EHy0u/C2uUqZqpkkmfvh3Q7n3dqajruehWDXxewG5sMyIVE+zBeqH
	Evbot4e5UHNHte/YpdX4IhvR2LhZ/mBoBo5bD65eiFPQqs9N+K6EhP8rovror59V1km647xhvY6
	damy3YoRlwVux96Be3VuqXxTXUotN51LranDjdluBJXReJJSqE0t2Vi6eamOwNTP8zWiUcDndcE
	SXYXf+U8dOLIuLLPxx9RU8qp7JZyqqA70RhXYQsb4HCapab6XQDQpKWAFgZ9CHo4XknLKj3jB0N
	XdkUzFnqR3JzLpaCVWb
X-Received: by 2002:a05:620a:45a5:b0:8cd:7d57:d613 with SMTP id af79cd13be357-8cdb5b8d73emr185570585a.55.1773350093009;
        Thu, 12 Mar 2026 14:14:53 -0700 (PDT)
Received: from localhost.localdomain ([129.170.197.126])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda2151db2sm401089985a.44.2026.03.12.14.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 14:14:52 -0700 (PDT)
From: Nathan Rebello <nathan.c.rebello@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Nathan Rebello <nathan.c.rebello@gmail.com>,
	linux-usb@vger.kernel.org,
	heikki.krogerus@linux.intel.com,
	kyungtae.kim@dartmouth.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: typec: ucsi: validate connector number in ucsi_connector_change()
Date: Thu, 12 Mar 2026 17:14:36 -0400
Message-ID: <20260312211437.433-1-nathan.c.rebello@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <2026031238-richly-tattle-eab8@gregkh>
References: <20260312060815.55-1-nathan.c.rebello@gmail.com> <2026031238-richly-tattle-eab8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linux.intel.com,dartmouth.edu];
	TAGGED_FROM(0.00)[bounces-225217-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathancrebello@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: BF9B7279DE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 at 07:25:54 +0100, Greg KH wrote:
> Shouldn't we "fail" something here?  If this device is sending broken
> data, we don't want the caller to just assume this succeeded, right?
>
> Shouldn't stuff like this be checked in a single call after read_cci()
> is called?  The other calls to ucsi_connector_change() are not operating
> on a "new" descriptor value from what I can tell, but I might have
> missed a code path somewhere.

Agreed. v4 moves the check into ucsi_notify_common(), which is the
single point where CCI is parsed after it arrives from hardware.  If the
connector number is out of range, we log dev_err and never call
ucsi_connector_change() -- the bogus data does not propagate.

ucsi_notify_common() returns void since it is an interrupt notification
path with no caller to propagate an error to, so rejecting the event
with dev_err is the failure mode here.

The other two call sites are not a concern as you noted:
ucsi_register() could be routed through ucsi_notify_common() in a
follow-up if desired, and ucsi_yoga_c630 hardcodes connector 1.

Nathan Rebello

