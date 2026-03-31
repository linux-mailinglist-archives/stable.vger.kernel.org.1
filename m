Return-Path: <stable+bounces-231337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFIJGAZxy2miHwYAu9opvQ
	(envelope-from <stable+bounces-231337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:00:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC576364B2A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28DF730293DE
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 06:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9EC3AB291;
	Tue, 31 Mar 2026 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="fi5ca9Jq"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613236AB6B
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940355; cv=none; b=N7pbMRgUa4dO4hIFXfnu6WwYG2EL3cttC5PiuRHRM+47xc3QFhFlvktg1j52rYhfiGVWDxpmixhxoimF5syMbsSKwEvuhl6oy7sOOebJrL8UUCT5J20LtrfkIj98cpemFCQy4z/N+f9cjrk0YMZYpNxBNRhaBh71qjU9Lhh9QqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940355; c=relaxed/simple;
	bh=57+hKfIZPpFepszkAZlPP1iv8WhctUR63y3BAVDRmBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEtHvac2H0v4L/6ymxiwlPy3qou8bRGsX2wuU8EpX8IFjkOUfHblKwPH1LLYR0QBkrDxYO7c6d6hMU2PmXtjrv4K3Blr/yLosrBsjKXT6Tq8Iv7s44d+8DKDjA4ZOaXzumVLW6DPLkNoySlmftBP8xOEDw3B/KnOK7bCnwLDP7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=fi5ca9Jq; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 49F453F278
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 06:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1774940345;
	bh=iEC5MJ8obDg2CLco5IwokHmKBCd99zm6WFzGzuqDmRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=fi5ca9JqxFj91dEuwtXp8gX9vbtKmz3IvpWsxJJsJJaAWO9CLLqR9Uej0Y32fDitI
	 0BDaNnIB4sbQ+P2KcwBu/vovw0IE8DF1gg78zEipyqhLusxtnJjstJ6AedmOHE/geF
	 jYcCWoRP8vY4/7hEwQvRSbiiWnzrNg0O/KbZPtvv8NHF2ARfA4VQer8B9wNX9kab6B
	 jBqaFYs4cOw3mkSjPWO+9rzSCUYqqjhqMqAqM85Z3Q+9isCcQGaCCUQxid7l16svWH
	 VDgOCA9578//+VAZZ8tQZdYwxbL8BU3pgfMMocJurq8tx+GGXTtTYJzGWaiYAnclnB
	 k0rOAwjBqJX90+qn3Nt/HZjXOURxTd7yIL8d86JJZ51FnvEq2+sV0Q8cxnjXuLB2hg
	 U+wQ6Ge5dppTeX9Pa4GNzgiqicGTou3yxMvgmk6WRBxKX1yK5jkExcpWWqv5VvF5PT
	 VhWDIBDblAokyPjkOXu2sJrg+tlMVVtIufHDZDQcxWTpQv/lo2mDsnw7UNd4re6vQK
	 sZahz/v9a5DF1FSy4OiH3d/DuWoka7xCJ+l+2gclwTgiyXEN2EG1fHtOMU5+Nu6XCJ
	 6lwzbXQiUL/3hyhLrWS4nTywsXAcXq7MJv8W0se6dupQB3Xt7S0xStKybDDFmKiEWG
	 k5/FRDpAqc8zRD8NOy8IJKyc=
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48722073bd2so34493775e9.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 23:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774940345; x=1775545145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEC5MJ8obDg2CLco5IwokHmKBCd99zm6WFzGzuqDmRI=;
        b=VP+xaFCKRO8tgyuaFWAZSS9z4aKDIbfMgh9YSx7P4oxQxXXJ4pwOsHT1njCcXVTitN
         gOKN9htBJDE5nheNY6clP2KlxjvdvK3hzaVLGQw9pKigwbMkhgALra0po990IxCISJR8
         m/wjeRNBYkBEnl4yC9DIVrNf8KT8HZvFi1JQY/ppgr2lJgEZxfVQRTSswOrf9I66m3Qn
         aPSYZPdS5Arw4vz9/eHWy9ljMcL4F25oyZJOCAArR7B58gGs01SpwErYY77rQ/Z2tRcr
         ZBo2qf/iRTAqYtolYhTFIPFjOL1d8P1Gyer/rDDHB1zlJeo3mUOAHdev9XB5plwgJy6L
         cvXQ==
X-Gm-Message-State: AOJu0Yw+4yMZBqJ7y/Skwa62o+5DKxzrpHGAqE6y2zgRO84fWIt2ahn4
	c3kE9CTycy7Q1L617q3PQ2PBf4M0UwSrte4iXf5crf+NjWsSlsCjq6fkLkBDFitaNFMKyQOQQVz
	iVxhXaEqy86V9wNW5AwN5u/NABe8VGFtgAmwPTGvQ3eFoH1YItwXnT201hBxQ2MbBUe3WeeXA1g
	==
X-Gm-Gg: ATEYQzxhe7XVURMDDigIicEMsSMgNY9I22aMz0bRkTD93BpoYyG3bgS9u/QHfWkEv9t
	jW3ire44sPFpgHQWs1CaZHXk7VKJMh/6qG6W8CiBDWmsJPDWbZiKkVJ9eDMz25fteL+NlgoDnPu
	1L0hzVdgaRPeWklgrL6VJrtEZQm/09o9Lo4qw9I+NnwmvH/fIRWm/YNIfBHZHjUVrsXYhaI5cy4
	kMw6rFyh6GYiXTwCA8u4K8ycBS3clflULQ/0bnIAP20vdA7ENTkcThrzZ9/VV1pW4QmGIWhR9qR
	BPiQ4ln8o82O17biMZoE+JpSx2SBtR4e+120fzMpovY5bCr7w28Li2EPoE35yhW3S9HvW1bQ4H/
	sIosnHwEIB+tiAXtn56LW6fQqjcM26aKKb6s2
X-Received: by 2002:a05:600c:a408:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-488783820d1mr28492245e9.8.1774940344877;
        Mon, 30 Mar 2026 23:59:04 -0700 (PDT)
X-Received: by 2002:a05:600c:a408:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-488783820d1mr28491995e9.8.1774940344507;
        Mon, 30 Mar 2026 23:59:04 -0700 (PDT)
Received: from [192.168.1.126] ([213.204.117.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c760320sm12494915e9.3.2026.03.30.23.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 23:59:03 -0700 (PDT)
Message-ID: <a7c5ecb2-d46c-4061-a70a-c7b149db56f2@canonical.com>
Date: Tue, 31 Mar 2026 09:59:01 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6.1.y] smb/dfs_cache: Fix NULL pointer dereference on
 session connection failure
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Steve French <sfrench@samba.org>,
 Paulo Alcantara <pc@cjr.nz>, Ronnie Sahlberg <lsahlber@redhat.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Aurelien Aptel <aaptel@suse.com>, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org
References: <20260319144929.455978-1-ghadi.rahme@canonical.com>
 <2026032339-irate-monsoon-76ce@gregkh>
Content-Language: en-US
From: Ghadi Rahme <ghadi.rahme@canonical.com>
In-Reply-To: <2026032339-irate-monsoon-76ce@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231337-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ghadi.rahme@canonical.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC576364B2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 > Again, wrong git id :(

Thank you for reviewing this.

There is not direct fix to this issue upstream however upstream is no 
longer affected by this issue.

The commit ID I referenced is the commit that indirectly resolved this 
issue by completely refactoring the code which led to the removal of the 
function I patched.

Is there a better way I can convey this in a V3 maybe?


