Return-Path: <stable+bounces-232947-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMuOJM0xzmnIlQYAu9opvQ
	(envelope-from <stable+bounces-232947-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:07:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 226D838677A
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B253302C372
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 09:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7723A30E82E;
	Thu,  2 Apr 2026 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3/uBPan"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A14531E856
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120598; cv=none; b=naUXdph16eUDchYmaV7i83BUn744WbWjwafOuchL6cy+hmEJ289Z/B/Vsv++Yb670mG7s47S5+DnFlbmB6C0IVepxpglMwpaFgt4v+Rm1bTX/YLIo3X2tRRlWLKsy3yh+sFKO7idllOwdCwXFtj/AfINvFCtioaiDk0vQ/X+asM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120598; c=relaxed/simple;
	bh=W0apAXOTK9JSsSkLiaJ+8pNqNHE6rVZimL6JrJeO3ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTPFNBjjDoYU8bgVLzERgQp0TSY5FDr8XHhmBhHEQPjA/8btCr1C4VS403qbyrJ4cmDdJQFu0iq/4VE9Y70wGCbDlHaF5m1Iyp1/xTUs/honUVw2sgcHUHFabSrzIt4DzOfAZHz5dCEdajXxpIaEC0TZneaTd4dF5eHS4tU646s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3/uBPan; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506a7bbe9d0so5278561cf.0
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 02:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775120595; x=1775725395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H76qre6F2wTwbw92iok4xKfJ+shcvU4/HxAz+muIw2Q=;
        b=N3/uBPan9mYckyTrA/m7HikJE7hYEzWQN/W/bcH0gn7kdTXavMUlfxbOCG5lDmPe83
         WrqIPhkClNF8wzJCLd3kx/OOC/TRPXo8V+4WVBzCPPmYg0iSbc1mXqUuF6LxFZFcMD5d
         e+pVDpsgyRmHqW4k7c+4P+gpDVxTVM7S2OcfO2YblQfY+SLDa1avf+syGAc1LIyXIcUK
         WyiA3AytJKfu7dEKqIA7Gc7WeSGXqJ1v+nv8/BRoaG99RsugDdULn2sZtE3tV+XUO93c
         IQMwU138lYhZCyenl7q+hBcsfO5VwPIZSujx8SuUiMevTP8QAxLR5+Ibn548dgc7rmS+
         CS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775120595; x=1775725395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H76qre6F2wTwbw92iok4xKfJ+shcvU4/HxAz+muIw2Q=;
        b=YlJ6b34/vGYOIPTt4RtT8mG/mO5rTGqXMNFnC9Lf3q2HUd6x4D89iuelPdZh09t+6y
         hwVjejifLqoWmKH8nv48GESicel3fzIkjPVTMRXsHOxL1BjZFh3W1CNo24sRtUT5WPQm
         XhdeH7CPuLQ8FjsUsF+BN9w3w1mvKY/JH2Guv2K/PExCdrCUQLAwSiJxz6A720nio0kM
         NJTmyXwtzoCBbUKfHQ4R7aX04pfFvb8Vr9HtrTtbcIfUiK2aoTnmmb73l9qOBURuW+6S
         4ZfSOUtQkSogxpqVD7Bw6ucMT8nknxQPOsap7F9dEf4dn37xyKrb3EHM0cCoac7seIca
         Te+w==
X-Forwarded-Encrypted: i=1; AJvYcCXNOUulHDPaCHS4GbbIueNBDkG7lA28FaLmJmwN7qNXRTifx0MvsuIMbrw6iSlA8y8iDklTYB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAinkEfb1PL4p5HZ16j9t/MjjZPejFYDnIznv0lY0TJn0lWZS4
	aCdJe1AUa2gu1cFxuydkYL/q0rCb154Eon8B/xVir1/uxV8pp/2zpcPg
X-Gm-Gg: ATEYQzxSv6XJvo11cjAdlFSqOF78Gi2/JxZ5FOugI15B4rG5ItCLx+RwIeU/Kqami8+
	HfdegedYynVSHBwpfDHr1UtS838NHiqEX52gO4JN04FkefwYoVWP7qnlB4IkKDYM56BSNIPyinQ
	JqQDA9DrOpCkafqYQqXGzW2nFiU5/r6BuBor9XY2AaivJHok3lxHrrVBNXqWDPeb7RinlqNF3ko
	HZcS5vkd3ocXd4hKC6h5FgreI8Aye5K0aeW1qClzUsUYC+ECAuA4o812EGo5aHQOiesqpqapcOq
	OTt5K64drE/y1X4OpH9Nqa5aaSj6p/FQcGhjHAkOnT7Okf16n3teg8xIUaE6R7cdh/WQZuJJhia
	8PgFkI6aLH/IxB4lMGpEdyEgsYbnS+g8+sUnGKvCtgsvikDwKC4HN8PqAf9OTyecFZl1rXqaYrs
	YlMwgS+lKLbN3CA6FHPo0ghDi1Tw5EJHHdB8u8VZtH99UADbTnAKFOJFxyWoqQUH9YFPcTWB8jk
	cxT30bDiz3bjHSLLSLh
X-Received: by 2002:a05:622a:428d:b0:50b:3f50:16c with SMTP id d75a77b69052e-50d4b9d273amr38055611cf.15.1775120595312;
        Thu, 02 Apr 2026 02:03:15 -0700 (PDT)
Received: from localhost.localdomain ([129.170.197.116])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b1a739dsm17857511cf.1.2026.04.02.02.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 02:03:14 -0700 (PDT)
From: Nathan Rebello <nathan.c.rebello@gmail.com>
To: gregkh@linuxfoundation.org
Cc: skhan@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	addcontent08@gmail.com,
	kyungtae.kim@dartmouth.edu,
	stable@vger.kernel.org,
	Nathan Rebello <nathan.c.rebello@gmail.com>
Subject: Re: [PATCH] usbip: vhci: reject RET_SUBMIT with inflated number_of_packets
Date: Thu,  2 Apr 2026 05:03:01 -0400
Message-ID: <20260402090301.224-1-nathan.c.rebello@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <2026040220-defeat-jokester-22dc@gregkh>
References: <2026040220-defeat-jokester-22dc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com,dartmouth.edu];
	TAGGED_FROM(0.00)[bounces-232947-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathancrebello@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 226D838677A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 02, 2026, Greg Kroah-Hartman wrote:
> This patch is somehow corrupted and can not be applied at all.  Nathan,
> how did you generate it?

I used git format-patch and git send-email — the patch had a
whitespace issue, sorry about that.

> Can you regenerate this against my latest usb-testing branch and resend?

Done — sent the v2 against your latest usb-testing.

Thanks,
Nathan Rebello

