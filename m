Return-Path: <stable+bounces-161705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B7DB02B0B
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 15:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E08A42EB6
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 13:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE980278152;
	Sat, 12 Jul 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="00NF4ZIe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB783277CB5
	for <stable@vger.kernel.org>; Sat, 12 Jul 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752328203; cv=none; b=Y4C4sAOerIPvU1MMu5vIdWyUvcBkdlpxBZ1nEYP6w1mmly7ykOcszVHSgmiaJ9y6L1K2yEqrGm15rwUhBaNM3fpOfRaICbTPjiiSDemJXPpxOuq7xUenHZqWAHql9x027X/ui17Cl9JLgJVH8FWVr/NVVXS0qDlzBMIbH14cEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752328203; c=relaxed/simple;
	bh=55BQMuXUP5Pr2+9mAOzufwHANDtT0G4A2pVwtXgJSIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjnQitWwjiHqtilTBT6f7OAUYjh+6hBR9esTIlDDZQ8k6lAMFdUJk5HaSV/f0aiS4hSltHK+CPKRI/CvLRPmmnaEsrgeEIuQqLnXHH3/ck2KgNp0KWdlF1rqJPfQZm63YLdBJGPYMWPXTlTj1u/P4Vu6Teva4YTIdq07qmEEMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=00NF4ZIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2693C4CEEF;
	Sat, 12 Jul 2025 13:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752328203;
	bh=55BQMuXUP5Pr2+9mAOzufwHANDtT0G4A2pVwtXgJSIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=00NF4ZIeg7h//k912jD2gbJAnOMJ+oQr82CzXMRn9qDFGlkz+et1Pf5FCCnvSvPm0
	 UQWP0Mn75QlTe3V6ILjsI44J1HymnI3zugBoDjBUagBwcQn9FQMeijfhrIsuoRwyCu
	 MxH0B0h4V+XW9iSSKOXfru6doxm/DVr77ztAYqzk=
Date: Sat, 12 Jul 2025 15:50:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org, Salvatore Bonaccorso <carnil@debian.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Eric Biggers <ebiggers@google.com>,
	Dave Hansen <dave.hansen@intel.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	holger@applied-asynchrony.com
Subject: Re: [PATCH 5.10 v2 00/16] ITS mitigation for 5.10
Message-ID: <2025071250-catfight-refinery-a614@gregkh>
References: <20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com>

On Tue, Jun 17, 2025 at 05:44:05PM -0700, Pawan Gupta wrote:
> v2:
> - Fixed the sign-offs.

All now queued up, sorry for the delay.

greg k-h

