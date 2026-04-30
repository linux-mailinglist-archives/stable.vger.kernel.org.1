Return-Path: <stable+bounces-242191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPbyJoSd82lJ5QEAu9opvQ
	(envelope-from <stable+bounces-242191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:20:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C7C4A6CF7
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D66930234EF
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 18:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7256E47CC63;
	Thu, 30 Apr 2026 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AposASQX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CDA47B432
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573239; cv=none; b=RlSC5RFBOwMG+/uA5/CKJbOyeU4PdCm59Spj6ndsundgcrPRPya/XCQBdw3iNmj7NC04C3VSED1JuxLvuqYbvHbQTcSxaFtxrARZkgIpJVn//0h/Kpfb/0AYE1+YuD8mYZtMb+/dFNgZxIIiTB/YFxN+FX9MBtq98PwK0hJQs40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573239; c=relaxed/simple;
	bh=tCw+g7/7gagsLPju3PCwMZhvzQy38+5YtWX9iaZdW2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aM83yW3G22IE0ZZTE0d6JSfI6OY5cgL5UkT2m9RPYXTzi5RU2V2W0O5I3DT+jcXnDYcP8NCgQs+iNKzUOmb2csdky8iDKwJq77aHwSiY+BXek2ODzJASZJBkH/2acxTv/pSK8fs2bhDgNHcpkYswcF8hnVwfXwgb4ExnPyUwD2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AposASQX; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f8cebc935so631779b3a.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 11:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777573237; x=1778178037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=klUdmlVlpNVXegQCoO7cd9DXbhq3zKfW/7g8zOSk7s0=;
        b=AposASQXhasbW4RnAqaUf5272lIrXoO1do32DcX92I3jHT8jBuxANAGJfqZv2/Ftn5
         ssryFyxhReByinqmU5rabUvbXia43VJevIh3EbUBvmfkhHY5l3k9m6zX49FGFsJEr6OU
         x7CggiQLrEiTmjQJ3Y7KNvB1u7FIAYKoAXPqo5tjY9XvBTL3o3eXzu4rvv70GN+asNVW
         LAWyABwcg+oUEC6OWshsDMwJvFuS5/MB3huSZJCMJq1tWZDgUyWfM/ozIiQNEksdPOm/
         /o+SAeAKHfAW00oj+qId+byc2m/TQZ8tKV91r/qDC+7xUD/6I0fEYuAFcKpmhnp4UOAL
         m7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777573237; x=1778178037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=klUdmlVlpNVXegQCoO7cd9DXbhq3zKfW/7g8zOSk7s0=;
        b=sXm+4PBbBseOuJBqwlbLmS7uYHYm/OJhm+XIZF484+uiTbnNi24oJBTbnll4XMMcER
         IaPfR3LSuLlhzyZrPucQ/il+OcD64IItEneK+aMPPZZd6nOHn+Oq/K6XwQcDTnr4h2N6
         DHiN+/NCRuOSHUHtNLQb/uE+uaEdmAIIUuy1f2QDmteeWmrA6GJ68ScPf9jPIu+/xxgL
         kfeuw4ROERM/3PbBJckB2gX2Xejyk/r4FnE80p/yIxx9sV0PNUYXwaK8+ZifKhomsSD+
         HbTGFUK0PKr6I3eeDX6mJHu5F7z/MO4ZRDNbOVWL9ZV53i+biOmFGTtISUhBzF3vPftx
         R8KQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dIgMKhm/gydfamleDtb1Yr9uQAzSpzCXqIi3CNxkGgP3DrmOGS32jsTphhTKcBoZSkt7g6oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGkNWOGPNjM7mlrOrmSSGqjXl+6lGU6dUeH7ZQWKMARfrYp1rP
	cMRorouRCj7li1M8g81p/J1wHaXLSRJyfg+1MNOVOWVXCbu2ob6EuVrj
X-Gm-Gg: AeBDietIvo4YdLQnNr6F1Q5w2cUEzGlzpYIxPqqz65ZE3afNEzeKGYKVXaZ/8N8oHIo
	Lv3P9FIikHLb6LxUG6sRXg8BMqaRU8EVuAUNox52baH6tsYtvQVJB1jhfNUGquwzPPqZCjLWt5T
	Op8o4TvJ8fhii5iOkBrmilDkLfvtwRiBNsp/3683q9bRlV9XNzcv/5Vv513G11c8jgugcpX55gq
	mpRDIhFSxBrt71afR7IenRHaWq5UC82nKGC53lFy25j8SHdjMjAMSempyRYXnTVocWx7kanWcwr
	61QsR5GaI62NXruDCioXi/glLUmxXLF49TFZ4riBEIOPdYuFtkW006+iDieeIqo6gmQM5eNJ0s5
	AIQOj3kyL6e0JbPTG3CHG0mpm95nGLbwjRgMRnFB7D8SVvWbqsJUAsQNupHFxyLeZohpIMIJBWO
	2mQRtbwhqbi525cxq/x8ywNEMQVZFpvYvnQeLZSmapMhmArth5dNS4n96mtA==
X-Received: by 2002:a05:6a00:174b:b0:82d:6310:2efc with SMTP id d2e1a72fcca58-834fdb874e8mr4549707b3a.17.1777573237278;
        Thu, 30 Apr 2026 11:20:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8351582e185sm330380b3a.3.2026.04.30.11.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 11:20:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 30 Apr 2026 11:20:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Wilken Gottwalt <wilken.gottwalt@posteo.net>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (corsair-psu) Close HID device on probe errors
Message-ID: <083849bd-9229-4ade-b60e-08cbc4ff1cd4@roeck-us.net>
References: <20260424135107.13720-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424135107.13720-1-mhun512@gmail.com>
X-Rspamd-Queue-Id: 25C7C4A6CF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242191-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:mid,posteo.net:email]

On Fri, Apr 24, 2026 at 10:50:51PM +0900, Myeonghun Pak wrote:
> corsairpsu_probe() opens the HID device before sending the device init
> and firmware-info commands. If either command fails, the error path jumps
> directly to fail_and_stop and skips hid_hw_close().
> 
> Use the existing fail_and_close label for those post-open failures so the
> open count and low-level close callback are balanced before hid_hw_stop().
> 
> Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> Reviewed-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Applied.

Thanks,
Guenter

