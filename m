Return-Path: <stable+bounces-238469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNuAJoz64Wn50AAAu9opvQ
	(envelope-from <stable+bounces-238469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:17:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2771441924A
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D85931ACEA9
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 09:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52E21D61B7;
	Fri, 17 Apr 2026 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvvB4395"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFDC372EED
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776417109; cv=pass; b=mZEyPUzsQ51N6wzf9Knx0RX5vk8dZMwMG95LA97dADcw/jQLe2yLwQm81gV0QQjl20ly6xjsApjoddy74yCfukIl2taGNwIg8SmNph6Cc+W8wMEozohjS1UnMkkq38WmzSvpSAC6kiuru+dGx5owFDjBIEjx8AR2sFyv9ZtQOyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776417109; c=relaxed/simple;
	bh=hZqD33S6TaBeP1U8RwrHN4MgbX19/ibIMOcdz9Suo8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTWIezovP94FQgVv7IfCk4XyDWue3cROIb4M0IfGgLhC8gLLPIbNxrUQX1k9kPUmW0dXuAh3uFDWnKQmL4qprYg88zIGv44uZZYCetb8t4vpppPpwZT4tzN/B7tPEgy7kIAztBFGMHCxUe24INnM9/JDwKiCiLtBcoQ4DDsKbGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvvB4395; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-651bc83e74aso431468d50.2
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 02:11:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776417107; cv=none;
        d=google.com; s=arc-20240605;
        b=XkpDMY3PlovIVQbaxZwVdVwkmebGjdbLQBRcRVgLzrAr70PO6YX2W5ilK6eR+arLyz
         0Sq6LhujJegg91+eapHepIaNo/9oJLmXhks3WRtEsxmEnUajDlRhzdr8KBgt3isq5DHt
         yz5PpCTP3m0ENh8MH8fkR348P0cqZhZlfBeZ79Mq6JVidFqbkLjb21DkBG7iDbgvkwFn
         9DA3qVnb08W+kZnTG2xUatNNkKPNZdkhPtcCibFbIB9XJp5adtLgJj3XI7ZcFSKmmpQj
         2XCiO40ghMQKc90pgdAwiYVhONtTU3sjx/BFWw1uI3jyDZyey/f5zSt/T0ANMjaq7ZGj
         h9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZZNEHLjnCSi0dTY0sR3/yoFnjW7rryZybDVgQX7Z80k=;
        fh=OJFFlsKyuJW3YibO7f33zx70Oav/u7WAgYfli6iZWxE=;
        b=c1yQbsxFrfCls2q30ERRFDuLYoZyCva4CJPgLDWnTRRNiI5LeRn8VyX7KJFN99VM64
         iLB59RBHHVFogTXchUI8sWjuNd5mcSH0hyDn/lsyDWx1zk6kbn34Du0jITwo+uIJgLqm
         3MF/hIiGcpaGScb43JECDnQJb6mQDdRR9RxnXa6yby6W06L+w9My/uzim+Dx8oqdXya0
         RkmxA5M2a639pv9QVWhn2dNm/KYSwTQ1J0BVRZqo4ajenrdimR+xRx953ul2NHsEUdFC
         gsGjeH9/hMpBjjvImtDMzODuymKNHdF9siZJ5T++ugCWOu5r0rDAuGR0U/lYBF5nzfkr
         Q4XA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776417107; x=1777021907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZNEHLjnCSi0dTY0sR3/yoFnjW7rryZybDVgQX7Z80k=;
        b=IvvB43953hh1JWstQdMvTra6f8piz8qfZNwY9O5eLBY0GahB8+T9JvFxOk1k8tQWvS
         D5ZwYzvDt4b60Cy1ap7l836GcmWNZRtjW61OKDsltx6PlS5PPJasJ6HhwqSl1WgrGlOm
         L3HBYtn53v5/O0iDSU9jkFXI7H2WihkVLxMBcn5Ma3D6yvgDA2SQxf8T/PKTHlNnP9rq
         LNejKM5BkHspvYFp+Yud1/ctMHR65K7OI2BujC1N2U6FWL/532cWRLnpkE6MeLH15pzt
         98rJT6tyv01K/EymmkiS7YQavuO8RNycSifcuX/8nHVgojXdq5abdkq3mfdSqRSzHZXk
         99Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776417107; x=1777021907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZNEHLjnCSi0dTY0sR3/yoFnjW7rryZybDVgQX7Z80k=;
        b=Jt7yrhm5IyCt9YmYzZMXjfrH9DuYm4Q8lbDWObfGNxPAJKOhUZuLwibTQtUc1YpGbx
         +HRgt5CSLwN0jgN8YLmEJ5Nu1vgvd0jmXV1lKIUPpKlyfEbPTqP19u3b69mKytSzc71K
         /6LCDTXG2JsdGE12Zq56IGCGvTWsagqkQlZxopBSizEXhu5nLlOjSluypRlKt7t2oASC
         kTAXP8Pj6NCH/Aj05S3/QUTaOzwQmbj3f39alRPa0okZdrnxfhl6NZLFoVkidKz0gHkA
         qOZ4YuGFFC3nZFowoGrBt+dIENKdVTMqyRj6oOLqC+CRcooKG5tmxth16I0GZd4QZpZw
         Kxhg==
X-Forwarded-Encrypted: i=1; AFNElJ9yYknXs5YbnUcHQRdmk5pa8Rjm3sCuEKyECh/UPz4A/LUyXHvszRF6Zf6906VR7CGzLi4S3rE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3R7B46OxBzDVOtXfPEK57SKdUGHrvKL+2j+R4b+lJl7ijEEy2
	rUde2JyEPbgMXQBht488nHv/bfDKL0LCOmXJqTHaBIiA/caD6TH1HFDfFtgEqXtScZCVVJX9/2O
	edcJD9QF7UIO+VAtS35r2eY6B2GgmfCBrIcTDNQoiUQ==
X-Gm-Gg: AeBDiesbabit5kcRdz39s2RFHjw7SMduVfo+AtlH9lBFTbY5pFe8/VX/sGAGuxgjy0A
	2lUnWoDmksUPhiLZRwUeGtMvtD3cIaE6MY1eSN5Cuuve31Z2g7MkUNOOmHQINeHrG99GV23Pejr
	rtZ/fa0TbtOwdDFPddtifTo4iaRG3f2AnimVqJGc/M09PceKp4jipM8FGGP/Ln4SGV0+Ea+lDQX
	4GFI//yHo019gWCw7y64Tlgu5W2kD9jjVdyfge/uOmdOHtQgMgHcnbzp5bFA1wmUTArS6k3uKLH
	x5pDx6FAzXKMdsN8Q0WL
X-Received: by 2002:a05:690e:130e:b0:651:d634:6d32 with SMTP id
 956f58d0204a3-6531085f25cmr1805344d50.20.1776417106750; Fri, 17 Apr 2026
 02:11:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415175038.3633384-1-lgs201920130244@gmail.com> <202604171609.wl8JLCit-lkp@intel.com>
In-Reply-To: <202604171609.wl8JLCit-lkp@intel.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 17 Apr 2026 17:11:36 +0800
X-Gm-Features: AQROBzCVBYydseR7J8ekLAtPw3aL9_q0Qe5MzF8i8S3g1XrJyVxsBCHjMaTpGHI
Message-ID: <CANUHTR8SyfZouETXFpDv4ivzin+DC8OTDYhbSQ1cRaoNqYPduA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: fix reference leak on failed device registration
To: kernel test robot <lkp@intel.com>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Olof Johansson <olof@lixom.net>, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238469-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,mail.gmail.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,patchew.org:url]
X-Rspamd-Queue-Id: 2771441924A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Fri, 17 Apr 2026 at 16:47, kernel test robot <lkp@intel.com> wrote:
>
> Hi Guangshuo,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on chrome-platform/for-next]
> [also build test ERROR on chrome-platform/for-firmware-next linus/master v7.0 next-20260416]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Guangshuo-Li/platform-chrome-fix-reference-leak-on-failed-device-registration/20260416-135638
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
> patch link:    https://lore.kernel.org/r/20260415175038.3633384-1-lgs201920130244%40gmail.com
> patch subject: [PATCH] platform/chrome: fix reference leak on failed device registration
> config: x86_64-randconfig-013-20260417 (https://download.01.org/0day-ci/archive/20260417/202604171609.wl8JLCit-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260417/202604171609.wl8JLCit-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202604171609.wl8JLCit-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> drivers/platform/chrome/chromeos_pstore.c:131:3: error: use of undeclared identifier 'ret'
>      131 |                 ret = platform_device_register(&chromeos_ramoops);
>          |                 ^
>    drivers/platform/chrome/chromeos_pstore.c:132:7: error: use of undeclared identifier 'ret'
>      132 |                 if (ret)
>          |                     ^
>    drivers/platform/chrome/chromeos_pstore.c:135:10: error: use of undeclared identifier 'ret'
>      135 |                 return ret;
>          |                        ^
>    3 errors generated.
>
>
> vim +/ret +131 drivers/platform/chrome/chromeos_pstore.c
>
>    119
>    120  static int __init chromeos_pstore_init(void)
>    121  {
>    122          bool acpi_dev_found;
>    123
>    124          if (ecc_size > 0)
>    125                  chromeos_ramoops_data.ecc_info.ecc_size = ecc_size;
>    126
>    127          /* First check ACPI for non-hardcoded values from firmware. */
>    128          acpi_dev_found = chromeos_check_acpi();
>    129
>    130          if (acpi_dev_found || dmi_check_system(chromeos_pstore_dmi_table)) {
>  > 131                  ret = platform_device_register(&chromeos_ramoops);
>    132                  if (ret)
>    133                          platform_device_put(&chromeos_ramoops);
>    134
>    135                  return ret;
>    136          }
>    137
>    138          return -ENODEV;
>    139  }
>    140
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Yes, the build error is because in the first version I accidentally
forgot to declare the local variable ret in chromeos_pstore_init().

Sorry for the oversight, and thanks for the report.

Also, the underlying issue here appears to be related to the
platform_device_register() core/API behavior. We are currently
discussing in another similar case whether the better fix, if any,
should be made in the core/API code rather than in individual callers:

https://patchew.org/linux/20260415174159.3625777-1-lgs201920130244@gmail.com/

Once that discussion reaches a conclusion, we will revisit this and
make the appropriate fix if needed.

Thanks,
Guangshuo

