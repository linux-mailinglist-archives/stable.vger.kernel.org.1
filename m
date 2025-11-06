Return-Path: <stable+bounces-192587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E693FC39C1C
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 10:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11AD3BFE84
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 09:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B25430AD11;
	Thu,  6 Nov 2025 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="J/w9+PqL"
X-Original-To: stable@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8CC30ACF4
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420105; cv=none; b=nuGdhN2FirvVKqdIRv3lUs2w3DipdH9gFJpL2gdCS1XvDHkABx6qBzq+RDnpcrk6zlVgzMNJFhfgJdxAxNctiIfO+MxU9biJGArLmDiW5bpePB2O7T0QWoEWZ0EDuamNz7sJhl/RSvJryTVrWy/EK/WlZqT6PNgof9up0NJS9vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420105; c=relaxed/simple;
	bh=JIXwOROFpFq5zfTO3uWEheOGcc4zUa9HNY3XJUwU7W8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UUA4KVuhM/2uTg6faR32TCnSLRokPG52PLf3F/PEuLIkd77yDygwFdcwi7h7oaT1oJGiCV6+odHnmJzzPl7ljcKbspTm/LAi3GuLmGDHlubERLI8UYTJGw0NVGKsxE5K5h1UtBMmFCcP1gmYa48cwKf6MwrIqU+IC5Rjn4vFZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=J/w9+PqL; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
DKIM-Signature: a=rsa-sha256; b=J/w9+PqLZV18SCTFHcCw+5OTEWNF+fARQe5tumH1CdTVYJIBv3ReFEds9Rlwi+n8DJ8ul7odnuGpv8lHFeWKJ/ABt361yaQj+IRN2y7O8w1zFHg4tLMGCVYdq8WShyB/O2aOAlkI422JVuiiOJ2rWZQnnKAUV39XAb3vhQ6aKqVOUTBEldqjZOtrcl0xArpcoLCzYj/EiBdjIVpOVXXjrjNiB9KkeNNF+E+3JfM731i/ExOkKv4T27gY7RGbULQ7CojCoAwik/9YNHzWwld4CmsstpigfmQgWUY4hUurZu7KXKFCqOJO+G9UYuopwtBy2a0tBUWOxlveMoWFB2C8Sg==; s=purelymail2; d=purelymail.com; v=1; bh=JIXwOROFpFq5zfTO3uWEheOGcc4zUa9HNY3XJUwU7W8=; h=Feedback-ID:Received:Received:From:To:Subject:Date;
Feedback-ID: 21632:4007:null:purelymail
X-Pm-Original-To: stable@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -128070862;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 06 Nov 2025 09:08:19 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
	(envelope-from <peter@korsgaard.com>)
	id 1vGvyY-006Qev-13;
	Thu, 06 Nov 2025 10:08:14 +0100
From: Peter Korsgaard <peter@korsgaard.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ivan Vera <ivanverasantos@gmail.com>,  git@amd.com,
  stable@vger.kernel.org,  Michal Simek <michal.simek@amd.com>,  Srinivas
 Kandagatla <srini@kernel.org>,  Ivan Vera <ivan.vera@enclustra.com>
Subject: Re: [PATCH v6.6-LTS] nvmem: zynqmp_nvmem: unbreak driver after cleanup
References: <20251105123619.18801-1-ivan.vera@enclustra.com>
	<2025110655-imprecise-baton-f507@gregkh>
	<87frar7gqz.fsf@dell.be.48ers.dk>
	<2025110624-huskiness-viewless-50fd@gregkh>
Date: Thu, 06 Nov 2025 10:08:14 +0100
In-Reply-To: <2025110624-huskiness-viewless-50fd@gregkh> (Greg KH's message of
	"Thu, 6 Nov 2025 17:51:47 +0900")
Message-ID: <87bjlf7cld.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

>>>>> "Greg" == Greg KH <gregkh@linuxfoundation.org> writes:

Hi,

 >> > Neither of these git ids are valid, where did you get them from?
 >> 
 >> git describe --contains c708bbd57d158d9f20c2fcea5bcb6e0afac77bef
 >> next-20250505~21^2~1^2
 >> 
 >> I guess it should have been fe8abdd175d7b547ae1a612757e7902bcd62e9cf
 >> instead, E.G. what ended up in master?

 > We can't take stuff in stable unless it is in Linus's tree.

Sure, it was apparently just the wrong commit hash used, E.G.:

git describe --contains fe8abdd175d7b547ae1a612757e7902bcd62e9cf
v6.16-rc1~30^2~32

-- 
Bye, Peter Korsgaard

