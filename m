Return-Path: <stable+bounces-249687-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD/pKdjADGqJlgUAu9opvQ
	(envelope-from <stable+bounces-249687-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:58:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A7758461F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 507C5307CCDA
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4C73B52F4;
	Tue, 19 May 2026 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUK2cafY"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357B53AE6E4
	for <stable@vger.kernel.org>; Tue, 19 May 2026 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779220437; cv=none; b=AOrsm0br8cJcVIeDFWu8eaGHaIene5UZaOU/kOBQyZyNVWAGZ7pdrrBRmIMcS80NUUXwNPvtgJP9hy6NZJHxriZHhcZ0pL9mEmpROWgUoKWlVNiLfRWNi4QnFR4PjsXYSwFw9s9ofPfNKjdNN/YJZEtpeXU/W4bZDds0wns9A+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779220437; c=relaxed/simple;
	bh=/yTXDUcSInNPHQIymKXgDkqeJ6bUbDCeIiKyGSieagQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llBYDvds6yFfZ/d4juzf+iZfTwnc9j/5ZhnlVNxRzEoJ1y8gt3gLlBUbIAr4H+bBbXA2HLYbeau5zdhKD6Htpwy9Uy/61d1bp92MC+dwkvokuBs7sDkQWJUuYjyowdOjA/2alkEhisIkCbwxAF2GKNmuZjhBmCOF8hyit9s8/+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUK2cafY; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso3630215eec.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 12:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779220435; x=1779825235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LBJpoz9+FDWyOZgmi5e6eowXrSWpVTMQLtjKWJI9K/w=;
        b=CUK2cafYarBHtR233nBcJ46qJEPUFZpr+AOUBxHFGSxbnGsdnWl0+yPx0xs+V3KPk+
         uZPg/UfIglkF2sHEMMltqQ7Oa4JlyWMTWmc9aSejgYSdkJ/5fv4EZJNXvhr6VuJfwKC6
         OwrPj3t9kWpDUuP+ZmDmcyILzK9HBkpAovEn2c6KxYc70uQLnLnInDGxRlJTOybm6OQT
         nj4i4MC8Da0j2PxS8VPVWmcqvGzMgATm3g+I+zNXWPBLleufCsHnbp0BmZi+9u7aE0jI
         ijNf/c4qp0/8LYmpzxKGNC7JOPasZoqBxxgdFZyfKXytuulTQ+N/CTWdjYGuvJXqwJ9S
         ifVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779220435; x=1779825235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBJpoz9+FDWyOZgmi5e6eowXrSWpVTMQLtjKWJI9K/w=;
        b=l3eRgzvMbbAkYSpTALKmNVHbnpiqdpNe8Opy97NXLsdKGgfAjc4UWtfEcYyiUqMwA1
         0mvF2PeaM/hOS4Ugpl6XX2LwCBBsgw6i99k4xYcgHWNSWoHwQV1Q71GPfH2W1GM+88r5
         p/Ex+EkRDNk/TrxsM9dmOc67JdsEgMaYjW3ovSiyBQxEy8SStJOkoi1/RCSGB54yxCiw
         SOug12o3K9ssa1nZFpsCRzKEu4kpSo0SCl8TTEiI9YU5lBa7eOKVV9weuFQoLj6aG1QC
         fOB0UmQ5dHtJJNsGjipGceNx2IgKAm4woGxnvLe/0zV7jSPjnnLPKicucyMzs0cVLgRU
         3TNw==
X-Forwarded-Encrypted: i=1; AFNElJ+2+k54QvP/olbr43LOSFWa77thQcdTQDvVHC92s/+JF7eR9Knhx2sHVDoRL2s4RBR3vvUSCzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhRGmVMTlpZG3/6wmRFXSJ1R1m/DZznai+8Vp4q20ME4tUZCOz
	fRm5x7o0XY8wg4R0oACm06HWGLgYtfi0/4FpEKLx9Qpq9o6vWotcayCS
X-Gm-Gg: Acq92OFbt/4hWPjflycio7g75cwEzufF+ikoLMOjqLMz6Qe0/KHLk4JK12VXduTfib/
	1mhXLey87DJCLRpD8WtBN20IELpEcAz8myvyrxM+pDmOdTQDiatmpKHCza6rtP/BJeAcMlGNys3
	VTcD/fZaDmL+VtSE/zYTX3gghqvRLovg3YmrxuqnZK2f6cf8lkD+7n9S8JVB5rA1jmO+XAZuVV6
	6WI/12Mb1RY5jdqZMZLqhEzeJEcH5QRfROpJf61zaNDNcWy9brANeEK2rg8avarQf1D17h6ME4t
	eTKrC/KpmLM84D8NtKBYh1UZ18M3Yhvqg6WZQW9PT97eFKtzExMPJWkvQMIHavVAE9wzJh2lEC1
	QEATheV++Map6ujTlLtkXKjJDrouxkW+xktdgRjKl/emvO19+wKvPbZCLvJWas03CfJxbSJUA4W
	PzyNnlSlT6CooUJgoWOgMYPfFYgRlHjYcWy9usDFBYwVjH+WaT9onsMg0f/SsDOsEFiU48oeg12
	znHyv8FdVtzMf8=
X-Received: by 2002:a05:7300:a94b:b0:2ed:a64:a457 with SMTP id 5a478bee46e88-303986552f6mr9519696eec.20.1779220435225;
        Tue, 19 May 2026 12:53:55 -0700 (PDT)
Received: from [10.69.76.71] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6e9sm20827669eec.16.2026.05.19.12.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 12:53:54 -0700 (PDT)
Message-ID: <67ad1039-b6e7-4507-a9be-12600a5fe385@gmail.com>
Date: Tue, 19 May 2026 12:52:36 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: lpfc: fix potential memory leak in
 lpfc_read_object()
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: justin.tee@broadcom.com, paul.ely@broadcom.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 jsmart2021@gmail.com, stable@vger.kernel.org
References: <20260519074230.110624-1-nihaal@cse.iitm.ac.in>
Content-Language: en-US
From: Justin Tee <justintee8345@gmail.com>
In-Reply-To: <20260519074230.110624-1-nihaal@cse.iitm.ac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[broadcom.com,HansenPartnership.com,oracle.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-249687-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justintee8345@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 42A7758461F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Abdun,

 > The memory allocated for sge_array inside lpfc_sli4_config() which is
 > attached to mbox, is not freed in one of the error path in
 > lpfc_read_object(). Fix that by calling lpfc_sli4_mbox_cmd_free()
 > instead of directly freeing the mbox.

I don’t believe this is true because in lpfc_read_object(), 
lpfc_sli4_config() is called with LPFC_SLI4_MBX_EMBED.  So, sge_array is 
not kzalloc’ed.  The code as it is today seems already correct without 
this patch.

Regards,
Justin

