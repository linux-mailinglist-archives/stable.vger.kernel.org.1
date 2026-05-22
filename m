Return-Path: <stable+bounces-253754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMxZJVIzEGqVUwYAu9opvQ
	(envelope-from <stable+bounces-253754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:43:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F415B25F3
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9FAA3009014
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 10:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5023CB90A;
	Fri, 22 May 2026 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeCtiRxA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1B73CBE75
	for <stable@vger.kernel.org>; Fri, 22 May 2026 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446268; cv=none; b=vGZTVsjWJaJk6sJxCZtgoKPmBgNOdW427+JjHzsaIjcMcL4ggbWIT8Rc9bWbDeRVk9QlZo7uO1i+SwSJVGdfo9wLQlfLyQla8ZW/Hg2g8CPoluWUqlEuxK21OhUL4eV55BAC1La+5RTHW1mSY1a2Gl/L9ewvNSymTjkYIQagOeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446268; c=relaxed/simple;
	bh=Ac4xnvnmTYeA2XO6wouWeRbpqTgtkLKatItCecIHYT4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=ardiGVTlPjB0ifCssPKj2RtU/GUv56Z+MbRtVuMppBJuO8zycydVeLMe3SHNUe2TTExZgGzsrUgyLDMm0OlQ2QzjxKahp40jhazyl+YRiNoNpfe2w1jkmUBjoysAoMeHZhhm6gFDKgZfHMc/YpG6I/7mBu6wCCboQesawkiYxvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeCtiRxA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6886be3d39bso2083642a12.3
        for <stable@vger.kernel.org>; Fri, 22 May 2026 03:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779446263; x=1780051063; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ac4xnvnmTYeA2XO6wouWeRbpqTgtkLKatItCecIHYT4=;
        b=WeCtiRxAUjVZYBIekn+j1tAurP+BrWtiwvGaNBZipS8+QFOssLnwSqA7dp4ORSHLaI
         qp/Itfe2Ykr209UNxoaofgWMsaoQ3ovf6ffaOjf1jcUZKU23jrEcIo9MP/1TBhOmxFSB
         dG15VTtVs9hCTwfouO2YGZEES9Y5x44IyaUXl7ZAIQD4cZi3uYLtrRlCEc/5HIz9tihk
         VqJTq7UW02McmuadUmWBY7l/YUCy0zsj4PP1EQP3Dbfly/p7kqUR2U+LykQfDBR0Eltt
         /iCQsavaBMSTpqPyQe98sRjsoSfAiCaPNmDXPOHpev8lQzDu9vfXRJzEpdVnwJb8bh2h
         PUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779446263; x=1780051063;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ac4xnvnmTYeA2XO6wouWeRbpqTgtkLKatItCecIHYT4=;
        b=DLICY8bAryuKDbXl2NMgFAtmDaPAsyPIaiRJo1hbEiRSW1tMuMKgtkiwfR/qhRH+nf
         KeiMJo+DHyWdu4qExW+ax8MOvF57hFzckBDwoEv8C7c+bnT8XsV7bL1nzhdbSpeG7uo2
         Q3fiGTa46iy6GJuuE4iwz/gKM031dZWXQ7OwNjLgwjFs33RIskz0r8RCeN8KUF54zIv/
         PuocEqGv8XO09vvAHEjf0DUUP3mAv2Rl5hDV1m+ORG3U0H7fS/B8tRnbgsGiKxVtB0c1
         tm6HVSfZC6awVvOu9XTPZ/XB8m3ybAPnWnikdmKn+lM45lfhbTU2UkGIj4jdpZtgnTwV
         USHw==
X-Forwarded-Encrypted: i=1; AFNElJ/Um+li3LSqNOJP0R7+mY9TC5ZMuPGO4UVVEwZc2Kob5HBZQl3XBF9j+ddWGkXhzaVJH3cnsi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsAtjKWrCWt/4ozKSfbgAPkO/8qtpLAPx51PnRd2Sdg6GTAqAX
	xwnaRrPzIRShaJ17X1GDS9sRcB6KaB5BZNHCCH0mRQiAe7vlWnrMn8Ed
X-Gm-Gg: Acq92OFLuw/Tk/c2h4eJZqBLuePMAXu4germ7tJtOftjXGKHQc9o99w6AeMy/pTuai0
	B9WNURNcsSJtfB+v0c0cqpA5anPxdIzHF0Rn4na9bdeMm0i0+LHBmuko+nCA2dHCTnzOzcHwN8d
	QByGmNuJ7lvlShnDMTZMUPNZNWZeoJqgDSY0twSwGSWQCqBpMQgvPpceClZpiiQxe3MV4YPj8h1
	E7bHrMRfqeSnlTf9p+DgIG5pW+UjsbvSzmw1qwPWl6qTUui2gaFqX1DWHtfM8wb4x700J+dMSq7
	jWxDC/+fhkVpN5dKLY8zj/2HX+QIJnFBjTbtlZeaGmI9+9jawDqxiuXASweMpMN2e61nA1fwuHj
	Lhd24/6bCreEOPRKjQsDaaH7w+/Z6r5hI2c6ZxZ/r7F1qVpAexA40fnvohygXX72W8dPJQDUxwj
	/svILCMX5ZWIA6ditbENqc6LPVZI/WaoCvNYpBdZwGtq0A4iK7G/dS3BZykbo8xT6F18m5fS5YF
	Y1Lj7siwZh358tJri+AG5w9DZw3oKxMkZk0NYuYcE/ACBMsSoLoR69CcGhaZAmigdv1182+pxAM
	OBco0kSe5pTBw2BY3oY2Zh6B7T+1
X-Received: by 2002:a05:6402:1cc9:b0:676:d8df:f8c1 with SMTP id 4fb4d7f45d1cf-6889cc544b4mr1427718a12.22.1779446262781;
        Fri, 22 May 2026 03:37:42 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688bb62b6dfsm513385a12.30.2026.05.22.03.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:37:41 -0700 (PDT)
Message-ID: <6a1031f5.e5f1cd4d.398bf4.edc9@mx.google.com>
Date: Fri, 22 May 2026 03:37:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: Hannes Reinecke <hare@suse.com>
Cc: David Disseldorp <ddiss@suse.de>, martin.petersen@oracle.com,
 bvanassche@acm.org, mlombard@arkamax.eu, target-devel@vger.kernel.org,
 linux-scsi@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] scsi: target: iscsi: validate CHAP_R length before
 base64 decode
In-Reply-To: <430612f0-53f6-49bc-acd5-e69df3b330da@suse.com>
References: <20260518121811.385350-1-hossu.alexandru@gmail.com>
 <20260520165259.272808-1-hossu.alexandru@gmail.com>
 <20260522003800.2323e11a.ddiss@suse.de>
 <430612f0-53f6-49bc-acd5-e69df3b330da@suse.com>
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253754-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.788];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mx.google.com:mid]
X-Rspamd-Queue-Id: 14F415B25F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCBNYXkgMjIsIDIwMjYsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBUaGUgbGVuZ3Ro
IGNoZWNrIHNob3VsZCBiZSBwYXJ0IG9mIHRoZSBjaGFwX2Jhc2U2NF9kZWNvZGUoKSBmdW5jdGlv
biwKPiB3aGljaCBzaG91bGQgcmVqZWN0IGlucHV0cyB3aXRoIHRoZSB3cm9uZyBsZW5ndGguIF9B
bmRfIHlvdSBuZWVkCj4gdG8gYWRkIGEgJ2xlbmd0aCcgYXJndW1lbnQgZm9yICdjbGllbnRfZGln
ZXN0JyBzdWNoIHRoYXQgdGhlIGZ1bmN0aW9uCj4ga25vd3MgdGhlIHNpemUgb2YgdGhlIG91dHB1
dCBidWZmZXIgYW5kIGNhbiBhdm9pZCBwcmVjaXNlbHkgdGhlc2UKPiBpc3N1ZXMuCgpUaGFuayB5
b3UgZm9yIHRoZSBmZWVkYmFjay4gQWRkaW5nIGEgZHN0X2xlbiBwYXJhbWV0ZXIgdG8KY2hhcF9i
YXNlNjRfZGVjb2RlKCkgYW5kIG1vdmluZyB0aGUgb3ZlcmZsb3cgY2hlY2sgaW5zaWRlIHRoZSBk
ZWNvZGVyCmlzIGEgY2xlYW5lciBhcHByb2FjaCBhbmQgSSBhZ3JlZSBpdCBpcyB0aGUgcmlnaHQg
ZGlyZWN0aW9uLgoKdjQgY2FycmllcyBEYXZpZCdzIFJldmlld2VkLWJ5IGFuZCBmaXhlcyB0aGUg
aW1tZWRpYXRlIG92ZXJmbG93IHdpdGggYQptaW5pbWFsIGRpZmYuIFdvdWxkIGl0IGJlIGFjY2Vw
dGFibGUgdG8gbWVyZ2UgdjQgYXMgYSBxdWljayBmaXggZm9yIHRoZQpvdmVyZmxvdywgd2l0aCBh
IGZvbGxvdy11cCBwYXRjaCB0aGF0IGFkZHMgdGhlIGRzdF9sZW4gcGFyYW1ldGVyIHRvCmNoYXBf
YmFzZTY0X2RlY29kZSgpIGFuZCByZW1vdmVzIHRoZSBwcmUtY2hlY2s/CgpBbGV4YW5kcnU=


