Return-Path: <stable+bounces-211289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG1yN/hscmlpkwAAu9opvQ
	(envelope-from <stable+bounces-211289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:31:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E7D6C754
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 444FA300C55D
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17905364E98;
	Thu, 22 Jan 2026 17:51:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91901337B8C
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104289; cv=none; b=a9/e2kDdimGeE6kZVTzA+3DzuJkvH8iouTbZGojXTxJvq7e+rqb254KU+gjeIKGoCXO7SDXwnns9ZaJlJqttH5zLEj0+cC144h/zO4VUkM7SF1mZRW9AGY5qlxBm4Yceb+HHjCd3KNXyoEiz6qrg8eZxxE40LfoZ/jdfcul1fFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104289; c=relaxed/simple;
	bh=DCBwcWz9AXkDhcquKFNtt0csf6CTIRyTZ6eLyuaJk0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdOboVwqZzf5ano4W1cruoNPcKCRUDmjz6LiYTR1UYxWRct8ZDz/ZesgnNHqGtY5S+kdIuN2qjf2ta9UlxSsuLwGm6MIBP6lzgURU4aJmDTI57VMYYJOFQwQrqS1O8eifkubSzUgNIQnf16m7h+uwI/MuasZgB8Z0B2x2oFnaUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 909F11476;
	Thu, 22 Jan 2026 09:51:05 -0800 (PST)
Received: from [10.1.196.87] (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67AF63F632;
	Thu, 22 Jan 2026 09:51:11 -0800 (PST)
Message-ID: <f969ae44-b0cf-46ac-9794-e07b9bcf69c7@arm.com>
Date: Thu, 22 Jan 2026 17:51:09 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Building perf is broken in linux-6.6.y
To: Greg KH <gregkh@linuxfoundation.org>, Thomas Voegtle <tv@lio96.de>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <3a44500b-d7c8-179f-61f6-e51cb50d3512@lio96.de>
 <2026012214-bobbed-shorthand-da8e@gregkh>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <2026012214-bobbed-shorthand-da8e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211289-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leo.yan@arm.com,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 36E7D6C754
X-Rspamd-Action: no action

Hi all,

On 1/22/26 17:07, Greg KH wrote:

>> Is that already known? Am I missing something here?
> 
> No idea, sorry, I'm usually not ever able to build perf for any older
> kernels :)
> 
> If that commit is reverted, does it fix the issue?  If so, can you send
> a revert?
I root caused the issue.

---8<--

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index adf4cde320aa..8d16619cd098 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -7,6 +7,7 @@
 #ifndef INCLUDE__ARM_SPE_PKT_DECODER_H__
 #define INCLUDE__ARM_SPE_PKT_DECODER_H__
 
+#include <linux/kernel.h>
 #include <linux/bitfield.h>
 #include <stddef.h>
 #include <stdint.h>

I will send a formal patch tomorrow. It needs to be applied to
the stable kernel, and it would be good to apply it to mainline
as well.

The mainline kernel is lucky that the relevant C files already
include the required header, but the above change would be more
reliable.

Thanks,
Leo

