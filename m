Return-Path: <stable+bounces-269511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HYmWBjoEQWrskAkAu9opvQ
	(envelope-from <stable+bounces-269511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 13:23:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C766D3AD5
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 13:23:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=FSutw9O5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269511-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269511-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE50F300D614
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 11:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A463A1A58;
	Sun, 28 Jun 2026 11:23:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1F8194AE6;
	Sun, 28 Jun 2026 11:23:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782645812; cv=none; b=loajmLx1E3qRzphcLMeZ4K4xHObeHiaEZ5XVBbpadew9t85SKa70lfz4YA2QP4vfqYneGXS3zJqLz9Jr+VLbRVaZuDLa0bIijOnJc5Amohysu++q3CQ6YN/pS0wj7Wq6c8b60sPw4MkvWkrGkMyboZV0KiDtud/wm3nUtus8wIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782645812; c=relaxed/simple;
	bh=+m4Zd+dC0Qbx+qEE6dG5GGnHVT/5LNDO3C75LwBTaFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Omzchk9GUftU6KnUOC0LMl/xWootX1Uullb+3urVJ+CMX/lgOXT5HKhlaq2wG6tAEtzWpk5jNqLnd1rrQ33D43nd0Ij5wymkNcWXjkjj2s3bdHjVDAN+r/NZx4LPyB27T/hgzpt7tkChnehbZXKP5wpziTp6pzLyCZO2lTTnNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=FSutw9O5; arc=none smtp.client-ip=101.71.155.101
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 440b0cabd;
	Sun, 28 Jun 2026 19:18:02 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: stern@rowland.harvard.edu
Cc: dawei.feng@seu.edu.cn,
	gregkh@linuxfoundation.org,
	jianhao.xu@seu.edu.cn,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re: [PATCH] usb: free iso schedules on failed submit
Date: Sun, 28 Jun 2026 19:18:02 +0800
Message-Id: <20260628111802.3342187-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1b80afec-0263-4e7a-8f9f-94abf15ae239@rowland.harvard.edu>
References: <1b80afec-0263-4e7a-8f9f-94abf15ae239@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f0df3648903a2kunm572a28491346a8
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSB8dVkxPShgdTBhMGBpPGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=FSutw9O57RfWwxc4mNC+yCPqdug2u76yWFJEZyzI8ryYgxuaiNi8nDxGn0O1VYkwAUEfcRZUJAUwpgedqXNtJvACV7YQlfE9cnGVTPZUnnjEq8RzMcUK3e282jxaTDcBRdJzkCCdX1dtgbk88SUwcNEKDfLNg6XYKQlhxTyc+pM=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=XR4XxvDozcd87t19jJawNld0zWG0g6kjr2+cWPEjprM=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269511-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stern@rowland.harvard.edu,m:dawei.feng@seu.edu.cn,m:gregkh@linuxfoundation.org,m:jianhao.xu@seu.edu.cn,m:linusw@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dawei.feng@seu.edu.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,seu.edu.cn:dkim,seu.edu.cn:mid,seu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24C766D3AD5

Hi, Alan,

Thanks for the review.

On Sat, 27 Jun 2026 15:05:57 -0400, Alan Stern wrote:
>>  	}
>>   done_not_linked:
>> +	if (status < 0) {
>> +		iso_sched_free(stream, urb->hcpriv);
>> +		urb->hcpriv = NULL;
>> +	}
>
>That's not quite optimal, because iso_stream_schedule() already calls 
>iso_sched_free() whenever its return value is < 0.  You should remove 
>that call now that the deallocation is being done down here.  And also 
>have iso_stream_schedule() clear urb->hcpriv in the other place where it 
>calls iso_sched_free().

You are right. I'll update it in v2.

Best regards,
Dawei

