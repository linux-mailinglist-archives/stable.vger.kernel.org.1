Return-Path: <stable+bounces-213186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAcmNj/CgWmFJgMAu9opvQ
	(envelope-from <stable+bounces-213186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 10:39:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD05D6E65
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 10:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E30FB300EDCF
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 09:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A36396D07;
	Tue,  3 Feb 2026 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9jDjWqg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99728396B84;
	Tue,  3 Feb 2026 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111548; cv=none; b=LrJckQLAmLiMiGrVTmsJ0+OSJ5LX86q/lwjTMTlchDPGahG9vZJmcrcdy0prZX14M1JFqLQ3+PLyRQ8mChef++vgRVORfCXDkOREDKVgB8V5vVAgy7QeS2B9jQuTAaJ6yXsu6NKk5rzjzVmMTOwNlsJpFrhowQMXEyXl/uei4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111548; c=relaxed/simple;
	bh=jKh3nsVkKyaOTC+nBV+HhjkbNrBWEjoVf/lPxnXu4j4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=mwbsuVz2/yBUTAE+lc3fE0OXL5EKrVxqfyNXt2BbabQ0hd3cix6LqDm2slRBlFX2dfJReefE/3lhNT09buvfqmV6ABu4ieu9vhPHVEs50pKNfloZRFSWK0JDnk5r29amjKats+u29SUU/3Npza0Wk1a1FhN4Lww1+2ZPcDTBihw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9jDjWqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209B3C116D0;
	Tue,  3 Feb 2026 09:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770111548;
	bh=jKh3nsVkKyaOTC+nBV+HhjkbNrBWEjoVf/lPxnXu4j4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j9jDjWqgKPpRMoaAXsCz3498dXemV1/jcqfjzetCuFK+LUokWdirFnmIjya6V1vNt
	 KQaVJ2flVJIWGmj/OmwvAjT4SySG15DY/wC0VNEBkTKDpI472AplOTznsZ+9kAAZF3
	 Ft0bgpc5NekNebIC2M9bQNYn4t/mxtTeITPLOEwI8pkTMlceKMqkgEAYm1BxMSc2b5
	 52HcSSRQzS6fOiq247mmnQPghwJkMMJezLyYNWp4EEiJF8Z6LHI2sMhlNf3ld+MHsQ
	 kCZ8236H083/ovRvkjO6TQdTbVy+lbvxH975/D4cz1ubLYjaxnZMGPvhXdClJAHwkv
	 fx0AJsK9V33Ow==
Content-Type: multipart/mixed; boundary="------------nzVOFNbc0HKHHOaDR6y7RaCB"
Message-ID: <4819ec3b-23b4-447b-b10b-0bd93a40dc5a@kernel.org>
Date: Tue, 3 Feb 2026 10:39:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: spacemit: k1-emac: fix jumbo frame support:
 manual merge
Content-Language: en-GB, fr-BE
To: Tomas Hlavacek <tmshlvck@gmail.com>, netdev@vger.kernel.org
Cc: linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dlan@kernel.org, wangruikang@iscas.ac.cn,
 stable@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20260130102301.477514-1-tmshlvck@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260130102301.477514-1-tmshlvck@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-213186-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AD05D6E65
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------nzVOFNbc0HKHHOaDR6y7RaCB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

+cc: Mark for Linux Next

On 30/01/2026 11:23, Tomas Hlavacek wrote:
> The driver never programs the MAC frame size and jabber registers,
> causing the hardware to reject frames larger than the default 1518
> bytes even when larger DMA buffers are allocated.
> 
> Program MAC_MAXIMUM_FRAME_SIZE, MAC_TRANSMIT_JABBER_SIZE, and
> MAC_RECEIVE_JABBER_SIZE based on the configured MTU. Also fix the
> maximum buffer size from 4096 to 4095, since the descriptor buffer
> size field is only 12 bits. Account for double VLAN tags in frame
> size calculations.

FYI, we got a small conflict when merging 'net' in 'net-next' in the
MPTCP tree due to this patch applied in 'net':

  3125fc170169 ("net: spacemit: k1-emac: fix jumbo frame support")

and this one from 'net-next':

  f66086798f91 ("net: spacemit: Remove broken flow control support")

----- Generic Message -----
The best is to avoid conflicts between 'net' and 'net-next' trees but if
they cannot be avoided when preparing patches, a note about how to fix
them is much appreciated.

The conflict has been resolved on our side [1] and the resolution we
suggest is attached to this email. Please report any issues linked to
this conflict resolution as it might be used by others. If you worked on
the mentioned patches, don't hesitate to ACK this conflict resolution.
---------------------------

Regarding this conflict, both commits modified independent code from the
same context: code related to the flow control has been removed, and the
one to frame/jabber size has been added.

Rerere cache is available in [2].

Cheers,
Matt

1: https://github.com/multipath-tcp/mptcp_net-next/commit/286ef2be604b
2: https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/45e15

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

--------------nzVOFNbc0HKHHOaDR6y7RaCB
Content-Type: text/x-patch; charset=UTF-8;
 name="286ef2be604bcb5d4ec28bb2d194865f61a52088.patch"
Content-Disposition: attachment;
 filename="286ef2be604bcb5d4ec28bb2d194865f61a52088.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIGRyaXZlcnMvbmV0L2V0aGVybmV0L3NwYWNlbWl0L2sxX2VtYWMuYwppbmRl
eCA0MGM5NTA0Yjc0NDQsYjQ5YzQ3MDhiZjllLi5kYWIwNzcyYzViOWQKLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvc3BhY2VtaXQvazFfZW1hYy5jCisrKyBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L3NwYWNlbWl0L2sxX2VtYWMuYwpAQEAgLTE5Myw3IC0yMDEsOSArMTk0LDcgQEBA
IHN0YXRpYyB2b2lkIGVtYWNfcmVzZXRfaHcoc3RydWN0IGVtYWNfcAogIAogIHN0YXRpYyB2
b2lkIGVtYWNfaW5pdF9odyhzdHJ1Y3QgZW1hY19wcml2ICpwcml2KQogIHsKLSAJdTMyIHJ4
aXJxID0gMCwgZG1hID0gMDsKIC0JLyogRGVzdGluYXRpb24gYWRkcmVzcyBmb3IgODAyLjN4
IEV0aGVybmV0IGZsb3cgY29udHJvbCAqLwogLQl1OCBmY19kZXN0X2FkZHJbRVRIX0FMRU5d
ID0geyAweDAxLCAweDgwLCAweGMyLCAweDAwLCAweDAwLCAweDAxIH07CisgCXUzMiByeGly
cSA9IDAsIGRtYSA9IDAsIGZyYW1lX3N6OwogIAogIAlyZWdtYXBfc2V0X2JpdHMocHJpdi0+
cmVnbWFwX2FwbXUsCiAgCQkJcHJpdi0+cmVnbWFwX2FwbXVfb2Zmc2V0ICsgQVBNVV9FTUFD
X0NUUkxfUkVHLApAQEAgLTIxOCw2IC0yMjgsMjEgKzIxOSwxNSBAQEAKICAJCURFRkFVTFRf
VFhfVEhSRVNIT0xEKTsKICAJZW1hY193cihwcml2LCBNQUNfUkVDRUlWRV9QQUNLRVRfU1RB
UlRfVEhSRVNIT0xELCBERUZBVUxUX1JYX1RIUkVTSE9MRCk7CiAgCisgCS8qIFNldCBtYXhp
bXVtIGZyYW1lIHNpemUgYW5kIGphYmJlciBzaXplIGJhc2VkIG9uIGNvbmZpZ3VyZWQgTVRV
LAorIAkgKiBhY2NvdW50aW5nIGZvciBFdGhlcm5ldCBoZWFkZXIsIGRvdWJsZSBWTEFOIHRh
Z3MsIGFuZCBGQ1MuCisgCSAqLworIAlmcmFtZV9zeiA9IHByaXYtPm5kZXYtPm10dSArIEVU
SF9ITEVOICsgMiAqIFZMQU5fSExFTiArIEVUSF9GQ1NfTEVOOworIAorIAllbWFjX3dyKHBy
aXYsIE1BQ19NQVhJTVVNX0ZSQU1FX1NJWkUsIGZyYW1lX3N6KTsKKyAJZW1hY193cihwcml2
LCBNQUNfVFJBTlNNSVRfSkFCQkVSX1NJWkUsIGZyYW1lX3N6KTsKKyAJZW1hY193cihwcml2
LCBNQUNfUkVDRUlWRV9KQUJCRVJfU0laRSwgZnJhbWVfc3opOworIAogLQkvKiBDb25maWd1
cmUgZmxvdyBjb250cm9sIChlbmFibGVkIGluIGVtYWNfYWRqdXN0X2xpbmsoKSBsYXRlcikg
Ki8KIC0JZW1hY19zZXRfbWFjX2FkZHJfcmVnKHByaXYsIGZjX2Rlc3RfYWRkciwgTUFDX0ZD
X1NPVVJDRV9BRERSRVNTX0hJR0gpOwogLQllbWFjX3dyKHByaXYsIE1BQ19GQ19QQVVTRV9I
SUdIX1RIUkVTSE9MRCwgREVGQVVMVF9GQ19GSUZPX0hJR0gpOwogLQllbWFjX3dyKHByaXYs
IE1BQ19GQ19ISUdIX1BBVVNFX1RJTUUsIERFRkFVTFRfRkNfUEFVU0VfVElNRSk7CiAtCWVt
YWNfd3IocHJpdiwgTUFDX0ZDX1BBVVNFX0xPV19USFJFU0hPTEQsIDApOwogLQogIAkvKiBS
WCBJUlEgbWl0aWdhdGlvbiAqLwogIAlyeGlycSA9IEZJRUxEX1BSRVAoTVJFR0JJVF9SRUNF
SVZFX0lSUV9GUkFNRV9DT1VOVEVSX01BU0ssCiAgCQkJICAgRU1BQ19SWF9GUkFNRVMpOwo=


--------------nzVOFNbc0HKHHOaDR6y7RaCB--

