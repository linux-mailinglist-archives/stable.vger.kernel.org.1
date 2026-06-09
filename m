Return-Path: <stable+bounces-262141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G1/cN75jJ2ruvgIAu9opvQ
	(envelope-from <stable+bounces-262141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:52:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8398C65B701
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:52:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VnHb4HEb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262141-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262141-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78C5C3028AD7
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 00:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D391275870;
	Tue,  9 Jun 2026 00:52:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F87D244667;
	Tue,  9 Jun 2026 00:52:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966330; cv=none; b=rsKIvIfPo1LEh2Uzk1v8aNqOm0fLXhmFTDTVifsi41EHp5N3SWMsQHO1jzraSztqu6HW/UBVJkhh3JmqZ0LD5gmFL5U+UQxBiDtOJr/5qUovMI9V/0p2qaolKzlFWAiSIuviFMxIqKtqmuH5VrA5bMRDG9yGAiUm8yAJdwRyIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966330; c=relaxed/simple;
	bh=AbC1Os04RepBBGA9/+97KeZpEtlWpGcLAskcgsY0LUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F61kYZ3+XV0pjKDRmvFNqenT+lP0j7z+ekrY8iUYUt/0r3AAgS91CVfovi+CUNDSu16nb1haJutqAArwISDcwNHbLYfOTDuJnTaSM5pnIObTV7mGcR0gcNN9tQhUjgUpLHb4adkLZ1VjgWyT2cr8y6/aSJkpnkZphpwKGKFwY6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnHb4HEb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDE11F00893;
	Tue,  9 Jun 2026 00:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966329;
	bh=AbC1Os04RepBBGA9/+97KeZpEtlWpGcLAskcgsY0LUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VnHb4HEbpeYop2++BVhPZ2cEwb2uDwy2BvNTQmDttICoRXBwLySE5hVCno0hVBHCL
	 yF436ulK3n6fxAihqgHC9+JkDsSeRxlmBk7EXrNxEpnXZhIDHbY6sp7E3N1tkyG2UL
	 xiv0642RtsMOI04CAc0TDoSAlWSpWI4jbUY3Hj/eDwB0bmKC5ZICIxymxiH0stTMo1
	 46x/N5P6Io5ee38RzBvVsrPFNEmt02RNyszL7NJ4wIfIfBkQYpnDMxy7ntCSTSYD7g
	 HMoj9RvhSDxIAN/r2LEQCrAP9s7jCvbmvVoHaIYSgv8WqGPJnQr0To1txlvM5JBGNR
	 aEhy4UFWq2Rhw==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: Re: [linux-5.10.y 1/3] HID: core: Add printk_ratelimited variants to hid_warn() etc
Date: Mon,  8 Jun 2026 20:51:48 -0400
Message-ID: <20260608-stable-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608100236.2781796-1-lee@kernel.org>
References: <20260608100236.2781796-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262141-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:lee@kernel.org,m:jikos@kernel.org,m:benjamin.tissoires@redhat.com,m:vireshk@kernel.org,m:johan@kernel.org,m:elder@kernel.org,m:gregkh@linuxfoundation.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:greybus-dev@lists.linaro.org,m:linux-staging@lists.linux.dev,m:sashal@kernel.org,m:stable@vger.kernel.org,m:vi@endrift.com,m:jkosina@suse.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8398C65B701

> [linux-5.10.y 1/3] HID: core: Add printk_ratelimited variants to hid_warn() etc
> [linux-5.10.y 2/3] HID: pass the buffer size to hid_report_raw_event
> [linux-5.10.y 3/3] HID: core: Fix size_t specifier in hid_report_raw_event()

Whole series queued for 5.10, thanks.

--
Thanks,
Sasha

