Return-Path: <stable+bounces-215801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKxRB1h0jGk6ogAAu9opvQ
	(envelope-from <stable+bounces-215801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:21:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89692124285
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78B7B3014120
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4B932B989;
	Wed, 11 Feb 2026 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nyKK6ZmP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC928D850
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770812499; cv=none; b=G/K647tlnYc6HH46PLxXZgrMjvB1GxhSUvVgOSjdfT1/B8kxC4bnnvIc1HcwTQP34E+dZ6f/Sra+4c/5Of8/0ONCiFssy6cumlFRbU9RbcgE/pIF4ENhtWliYtjROzmfhnQ9XZdelKv4Pkhc8xIxwGe8toeI1BfjGQUfdaubtcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770812499; c=relaxed/simple;
	bh=b7jKGrI1nCLl5/vavw3rthOyomE1aVjPemkMBVD/m3I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=lE/ztmLdTZegTOlYkFFNNkLMFfHrXZPnT0/eBItl6cWJ1A5oHe3pdiU/3G0sTN/30pqrpOiXaQf9MjSpILAOB29jjpLyPgn/xo6TlcviQupFP4hjexcLfzqZCQBlKWEf4SLcDQMUpm6hEIh3OIT+MOGVQ8mcqSh2M+sw0fL2bhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nyKK6ZmP; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7cfd6f321b5so1137400a34.2
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 04:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770812496; x=1771417296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UAB1dbhX1IyH8NFo1jGMuN7uCLDRTVNN8JJo6WSIbQ=;
        b=nyKK6ZmPq9v29IChPSJ8mvIr557uTyAdk/KuCmTP5lyOA/tFuuh6FDkb4Gboir262W
         W3DDD6T6LwzLUQaTCTWIPJgPkXYBJdYJm6hM3urqUtDF6ZmCLYMYhdfksI9fVcsXCC+a
         jTm/kvV8KjtntfRxJcrINLcNfOvactMYTiN85HqJbGy6uLTzlU7w2vylBfnGgeAhTI1L
         hLs/jOCCZUOT7e5mC8dl/5gOquYJ8dO/wWcOnuhyGxgyYBR/oOiAm9/L3jvYn+SU7V5e
         qZjqfF8R7ens1sW1zY26ZlJPF7rRCsE9GWGdbFcblTnBqm9AcPYg0AEnymlfCUtO3/Ko
         +pRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770812496; x=1771417296;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4UAB1dbhX1IyH8NFo1jGMuN7uCLDRTVNN8JJo6WSIbQ=;
        b=q0LDo1yAqip035QMxAhm52SUyj+V55e/CAvr+l8AybRSmDMdioqr/YVceEyIP05x5N
         eedp+eVhC6oAbJ2bRUDquzdMAhP77++Q9v4nYj+XUvQTBUzUz8Z1OGYEVOrKV3xNgDEE
         VR/4dHOzBwCyKDBoV6MliRyDWTy1RJy/h6Kg14ugcgLobmeNfwEYbkGqED5AjVAFRYeH
         tq6x3iJXc6lDYbuzd80mz4BMu7jaEoDRMlN9vO/D+WCr1svWftgPVDj7Pblwx7x69Xlq
         9p35td53aImbpZcBVxQm1X3mmcnqf8/ldZ6rYoWTmjvPhbbVM7+QYyzio4mhxoetGMs/
         zIzg==
X-Forwarded-Encrypted: i=1; AJvYcCXIxJd72d/vB8IrK4RhNbYaAm59avsoYK53hYLAXzox24M95IFruh5UWwUr7QAO/e8XJAzSdFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfjwIcIw/G1n9M/BQVZ2I+vZolQCahuISLPuwmRDXr/VOdkqs6
	a1x6UhTk9694KIG0Np6EyoTtCK06OVXeTkBMhCE/2BxheJJ1k+WmWFPoTuwfcXDEhjNJesxI24/
	KGDqempM=
X-Gm-Gg: AZuq6aItvFMNqTDFMaBZBBW9QMueGz9fNYE5IsV4EX17I74oU1ST0ekedKiivgFpxBe
	b5MMJgsYcJWf5IPnvxzQ0dSUTMD+vKrM6iDkuA72NyOSXjHofIkUhrevpb775a8oxIxd5R9hI9B
	2XPQbTl5ZGEvwEZ4/Pq63SojRx5brEVSwwKblawsFYiSMKFrWFL9FIlsFE51+qzqZJEPOvTrWsY
	1+zvFAqMNw7vEbGtn+hsyW14qRuR8k3jdC1RhTc0KR0007A+x0Bd/Wbhv3j7i91dSLrS2gGoHpA
	Ko9W5vAdA1s8SAF+IcIprTmAQTMUT/l/j7YWXfBrDo1dGMyOTi3cOCKcgEZNgFZs0cEkgh9PhXb
	+Kp+sPXoZlcG/MgYyTwptYco+AyWCMW9oLpiCx3OX1DIdkSiUTCwbFZuWMc953FZk2ViKuZHs0d
	WE3NamAHo3ZtH3pDgURdIakQJ3OWeiUFCpdjSIbgZ7D71MZcHAvltXwNHnancDwUaGfHm2IGE28
	3mAfrswqaDxYOVWgNhl
X-Received: by 2002:a05:6830:638c:b0:7d1:4e51:e45 with SMTP id 46e09a7af769-7d464485cdcmr11984551a34.17.1770812496552;
        Wed, 11 Feb 2026 04:21:36 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a75309bcsm1151782a34.1.2026.02.11.04.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 04:21:36 -0800 (PST)
Message-ID: <faa3e25a-ab8e-4589-aa4f-6f58bd93a636@kernel.dk>
Date: Wed, 11 Feb 2026 05:21:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.18-stable inclusion request
From: Jens Axboe <axboe@kernel.dk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable <stable@vger.kernel.org>
References: <7923dc60-dbf5-44aa-9aab-1c474cea0039@kernel.dk>
Content-Language: en-US
In-Reply-To: <7923dc60-dbf5-44aa-9aab-1c474cea0039@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-215801-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernel.dk:mid,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 89692124285
X-Rspamd-Action: no action

On 2/11/26 4:49 AM, Jens Axboe wrote:
> Hi Greg/stable,
> 
> Can you add these two patches to the 6.18-stable queue? You can also
> just cherry pick these in order:
> 
> 38aa434ab9335ce2d178b7538cdf01d60b2014c3
> 91214661489467f8452d34edbf257488d85176e4
> 
> It's in the nice-to-have category just to be consistent with the
> older/current stable release.

Oh and since 6.19 is out as well, 6.19-stable queue as well, please.

-- 
Jens Axboe


