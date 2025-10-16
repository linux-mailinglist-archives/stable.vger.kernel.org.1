Return-Path: <stable+bounces-185933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EB042BE24B7
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DF1C352896
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108712DC760;
	Thu, 16 Oct 2025 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AI0VuJUr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729FB30FF0D
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605726; cv=none; b=uAKO8n+1FZJrj2I7KvIVyj/BAQfv6Wezm9RGnOonFd90oyMfah+EIIS7nU3jRlvwuPeRlxjBkvmnPJflhKgN+gVAMEYK8Y8qn1RnYnUYxeiANPa9eqdd9lQkGFOKFqtpgRYQ2uI3XFwJCwT463xwOMj4XUSvWkmMG4NOKVVkvx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605726; c=relaxed/simple;
	bh=PJhgVxQ6l3F2XC+0qU3KNpBkHkqjfZDXMbafeVOMr6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YigVDD2gSQxKdo6WPF4xpmOVNyVS1lQGY96yjLX0fbDazso2SlZoF4CXNrtloMma03hLnRtHsfCnoe7UIuArxI90epZbE908XgHrpVt9bdB0LYdbXtXp/GAjsrVoei9IZLqqyRyUM4EV/xLIiWJlcJ44NUeKCFUlZVZKT18AvBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AI0VuJUr; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so446946a91.2
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 02:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760605725; x=1761210525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3p8RmPffIQDnvd5kvL8k++W8iQ6ICiKwTx4fQaUfQy0=;
        b=AI0VuJUrPWHGimUV1QyOAyhkyTmoBvnDQYTExv6LxTSoS9Z2dat1Cb/9ThIk/fSRIc
         YjMxrFIO68pxwnNu2vC1+E6AkbHXzjqkhWjVP0jp0kVdvsNHzi3W+I2J9VhWnBgiAOmH
         kSu/HEPrI73PSDp/34YiDQJO6QCBZiTE26ix4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760605725; x=1761210525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3p8RmPffIQDnvd5kvL8k++W8iQ6ICiKwTx4fQaUfQy0=;
        b=vHCbFIKr/cATpYAGmSorBo5OENhYCiLg+p0L87fa8nQnxY4AMns3q0tXOvSNVM0wbI
         zuMaOyvo+VHsE0cYGaynC3k6OVew37r1vYoBWW0OWpyhw1N7Ic9lzJ7BeBK1TGz42CFC
         pCjmQYixoOyFZbKG5BtLaeaYq/cNXpUt1MPljqH1fnKBa7QqaNMuXL7bUhKRgeVK1xbv
         aIh5o81UyNcwA6Vy04cYG4pquaO1eh5bq816w3V5jPGAM8lCnklbdXUb8kA6A1SsR6RC
         HD/UrZMtNGXqInjik4/s7do+4Iw3pJwzix6JNr4OkPVNp4SuhjIuQlJzRDSTNjQYeI80
         nOJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV96drlJq3OhS5i2g8PRby3CbGmS1wkbOTbMA0Mh9PJ7cvJQNg2W1Q2+mnL8sDmNGGbGuTeskk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRAEOxGq5abeq+bY2Vkdn0ksA4i0+rmKBbpeUujdJfn7oOBMxz
	BAbtLFlOvQ54uZ3qJmgQCYeiBoAU2zYzsQDNssE1CopSL8cOAnmGefo77Qjm0ZgqYQ==
X-Gm-Gg: ASbGncucm4xVc89mO4Us/DWZLStez61o1Y44XeyfigEzpKzqBAEEi24wOadRK8L2NkU
	yliXEQ8o64TzM7a3VrxpDZwB5GbTm+1yGCVghNk9fnKoxwRVaY7FPNdOO2CrZgzfzZ4bWdPhHCX
	sh5jvtiWq+ipDkHxhpDwKjob5b8b9x1oNiNEryXb21OOjjk2CP6LOzIDKl0hOQrhrJJHZq35FpI
	sqC8OTQtrLuuMc2oPdX4/nl/Bo6bcWqDAu7aeQnQSMG9YY7p8kPvdcwIZmUtwrp5g+fGcLM1FgI
	nCOiLvqKGOeVIkAozobeGjcFcpMbgDQM0c+ycHPG9v5jkGdEJ4Y7oeZ8IQ8A2go3DkD/FRlzxZD
	VuBuVCpj3t4SmX/RyrV/Guukx62d7M4yQM+dwAGqHI9hmzPQdkTqtmjYIU2cyLi/kyHrIBXOCBC
	Pqyv8=
X-Google-Smtp-Source: AGHT+IG33msCiI4gl7fX7LUHpwD1gOVp8mJCjmKIrALkWJD6ztf8tHjsHTRH/cSKPWoLdQIDz3SDow==
X-Received: by 2002:a17:90b:4f90:b0:32e:7c34:70cf with SMTP id 98e67ed59e1d1-33b513be266mr38568588a91.36.1760605724741;
        Thu, 16 Oct 2025 02:08:44 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:98b0:109e:180c:f908])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bae353b1csm694347a91.6.2025.10.16.02.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:08:44 -0700 (PDT)
Date: Thu, 16 Oct 2025 18:08:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, stable@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Christian Loehle <christian.loehle@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] cpuidle: governors: menu: Avoid using invalid
 recent intervals data
Message-ID: <s7rjg3bxmjqxmqxppivrunk2awl2zwgxz7zb3godj3s2tvktg6@twicqbqsnuqk>
References: <20251014130300.2365621-1-senozhatsky@chromium.org>
 <2025101614-shown-handbag-58e3@gregkh>
 <p7j4aihzybksyabenydz634x4whuyjxsmvkhwiqxaor5uhpjz7@3l7kud4aobjf>
 <2025101606-galley-panda-297b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101606-galley-panda-297b@gregkh>

On (25/10/16 11:05), Greg KH wrote:
> I've queued up a backport I did with a cc: to you on it already, that
> should be identical to yours, right?

Looks right.  Thanks.

// I wonder why doesn't git cherry-pick -x add SoB automatically.

